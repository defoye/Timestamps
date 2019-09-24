//
//  DashboardViewController.swift
//  Timestamps
//
//  Created by Ernest DeFoy on 8/4/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import TableauxUI

public class DashboardViewController: UIViewController {
	
	let viewAdapter: DashboardViewAdapter
	let port: TableauxPort
	let tableView: UITableView
	
	public init(viewAdapter: DashboardViewAdapter) {
		self.viewAdapter = viewAdapter
		self.tableView = UITableView(frame: .zero, style: .grouped)
		self.port = TableauxPort(tableau: viewAdapter.tableau, tableView: self.tableView)
		super.init(nibName: nil, bundle: nil)
		
		self.tableView.register(RedCell.self, forCellReuseIdentifier: RedCell.reuseIdentifier)
		self.tableView.register(TimestampCell.self, forCellReuseIdentifier: TimestampCell.reuseIdentifier)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override public func viewDidLoad() {
		super.viewDidLoad()
		self.view = tableView
		
		viewAdapter.buildTimestampSection()
	}


}

