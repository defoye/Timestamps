//
//  TableauxDataSource.swift
//  TableauxUI
//
//  Created by Ernest DeFoy on 7/22/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import UIKit

public class TableauxDataSource: NSObject {
	let dataSourceAdapter: (() -> TableViewDataSourceAdapter)
	var delegateEndpoint: ((UIMessage) -> Void)?
	
	init(tableau: Tableau) {
		self.dataSourceAdapter = { return tableau.dataSourceAdapter() }
		super.init()
	}
	init(tableau: Tableau, tableauxUIView: TableauxView) {
		self.dataSourceAdapter = { return tableau.dataSourceAdapter() }
		super.init()
		tableauxUIView.dataSource = self
	}
	init(tableau: Tableau, tableView: UITableView) {
		self.dataSourceAdapter = { return tableau.dataSourceAdapter() }
		super.init()
		tableView.dataSource = self
	}
}

extension TableauxDataSource: TableauxDataSourceDelegateAdapter {
	public func relay(message: UIMessage) {
		delegateEndpoint?(message)
	}
}

extension TableauxDataSource: UITableViewDataSource {
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
		
		let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
		
		if let delegateAdapter = cell as? CellDelegateAdapter {
			delegateAdapter.addDelegateAdapter(delegate: self)
		}
		if let tableauCell = cell as? (UITableViewCell & TableauCellProtocol) {
			let data = self.dataSourceAdapter().cellViewDataAdapter(forSection: indexPath.section, forRow: indexPath.row)
			tableauCell.configure(data: data)
			return tableauCell
		}
		
		fatalError("Register a UITableView Cell that conforms to the TableauCell protocol.")
	}
}
