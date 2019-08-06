//
//  TableauViewController.swift
//  TableauxUI
//
//  Created by Ernest DeFoy on 7/20/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import UIKit

public protocol CoreTableViewControllerProtocol {
//	init(dataSourceAdapter: TableViewDataSourceAdapter, delegateAdapter: TableViewDelegateAdapter)
	
	func interpret(message: UIMessage)
	func didSelectCell(atBucketIndex bucketIndex: Int, withAdapter adapter: TableauDataAdapter?)
}

public class TableauViewController: UIViewController, CoreTableViewControllerProtocol {

	let dataSourceAdapter: (() -> TableViewDataSourceAdapter)
	let delegateAdapter: (() -> TableViewDelegateAdapter)
	
	let tableauView: UITableView
	
	public init(tableau: Tableau) {
		self.dataSourceAdapter = tableau.dataSourceAdapter
		self.delegateAdapter = tableau.delegateAdapter
		self.tableauView = UITableView()
		super.init(nibName: nil, bundle: nil)
		
		self.setupCoreTableView()
	}
	
	public init(style: UITableView.Style, tableau: Tableau) {
		self.dataSourceAdapter = tableau.dataSourceAdapter
		self.delegateAdapter = tableau.delegateAdapter
		//
		self.tableauView = UITableView(frame: .zero, style: style)
		super.init(nibName: nil, bundle: nil)
		
		self.setupCoreTableView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// Delegation Endpoint
	public func interpret(message: UIMessage) {}
	
	// SelectableCell Endpoint
	public func didSelectCell(atBucketIndex bucketIndex: Int, withAdapter adapter: TableauDataAdapter?) {}
}

extension TableauViewController: UITableViewDataSource {
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataSourceAdapter().numberOfRows(inSection: section)
	}
	public func numberOfSections(in tableView: UITableView) -> Int {
		return dataSourceAdapter().numberOfSections()
	}

	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let identifier = dataSourceAdapter().cellIdentifier(forSection: indexPath.section, forRow: indexPath.row) else {
			fatalError("No ViewData Adapter")
		}
		
		let cell = tableauView.dequeueReusableCell(withIdentifier: identifier)
		
		if let tableauCell = cell as? (UITableViewCell & TableauCellProtocol) {
			let data = self.dataSourceAdapter().cellViewDataAdapter(forSection: indexPath.section, forRow: indexPath.row)
			tableauCell.configure(data: data)
			return tableauCell 
		}
		
		fatalError("Register a UITableView Cell that conforms to the TableauCell protocol.")
	}
}

extension TableauViewController: UITableViewDelegate {
	
	public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if let height = delegateAdapter().heightForCell(inSection: indexPath.section, inRow: indexPath.row) {
			return CGFloat(height)
		}
		
		return UITableView.automaticDimension
	}
	
	public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard let identifier = delegateAdapter().headerViewIdentifier(forSection: section) else { return nil }
		guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? TableauCellProtocol else { return nil }
		
		let data = delegateAdapter().headerViewDataAdapter(inSection: section)
		
		view.configure(data: data)
		
		if let view = view as? UIView {
			return view
		}
		
		return nil
	}
	
	public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		guard let identifier = delegateAdapter().footerViewIdentifier(forSection: section) else { return nil }
		guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? TableauCellProtocol else { return nil }
		
		let data = delegateAdapter().footerViewDataAdapter(inSection: section)
		
		view.configure(data: data)
		
		if let view = view as? UIView {
			return view
		}
		
		return nil
	}
	
	public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return CGFloat(delegateAdapter().heightForFooter(inSection: section) ?? 0)
	}
	
	public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return CGFloat(delegateAdapter().heightForHeader(inSection: section) ?? 0)
	}
}

// MARK: Helpers
extension TableauViewController {
	func registerCellTypes<T>(types: [T]) {
		for type in types {
			if let type = type as? UITableViewCell.Type {
				tableauView.register(type, forCellReuseIdentifier: type.reuseIdentifier)
			}
		}
	}
	
	func registerCellTypes(types: [TableauCell.Type]) {
		for type in types {
			tableauView.register(type as UITableViewCell.Type, forCellReuseIdentifier: type.reuseIdentifier)
		}
	}
	
	func registerCellTypes(types: [UITableViewCell.Type]) {
		for type in types {
			tableauView.register(type, forCellReuseIdentifier: type.reuseIdentifier)
		}
	}
}

// MARK: Helpers
extension TableauViewController {
	private func setupCoreTableView() {
		self.tableauView.dataSource = self
		self.tableauView.delegate = self
	}
}
