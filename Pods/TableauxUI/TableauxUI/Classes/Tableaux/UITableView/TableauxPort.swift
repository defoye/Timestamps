//
//  TableauxPort.swift
//  TableauxUI
//
//  Created by Ernest DeFoy on 7/22/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import UIKit

public class TableauxPort {
	
	private let tableauxDataSource: TableauxDataSource
	private let tableauxDelegate: TableauxDelegate
	
	private var selectionEndpoint: ((Any?) -> Void)?
	
	public init(tableau: Tableau, tableauxUIView: TableauxView) {
		self.tableauxDataSource = TableauxDataSource(tableau: tableau, tableauxUIView: tableauxUIView)
		self.tableauxDelegate = TableauxDelegate(tableau: tableau, tableauxUIView: tableauxUIView)
		self.tableauxDelegate.selectionEndpoint = didSelect(section:row:)
	}
	
	public init(tableau: Tableau, tableView: UITableView) {
		self.tableauxDataSource = TableauxDataSource(tableau: tableau, tableView: tableView)
		self.tableauxDelegate = TableauxDelegate(tableau: tableau, tableView: tableView)
		self.tableauxDelegate.selectionEndpoint = didSelect(section:row:)
	}
	
	public func attach(delegateEndpoint: @escaping ((UIMessage) -> Void)) {
		self.tableauxDataSource.delegateEndpoint = delegateEndpoint
	}
	
	public func attach(selectionEndpoint: @escaping ((_ data: Any?) -> Void)) {
		self.selectionEndpoint = selectionEndpoint
	}
	
	// Private methods
	
	private func didSelect(section: Int, row: Int) {
		let adapter = self.tableauxDataSource.dataSourceAdapter()
		let data = adapter.cellViewDataAdapter(forSection: section, forRow: row)
		self.selectionEndpoint?(data)
	}
}

