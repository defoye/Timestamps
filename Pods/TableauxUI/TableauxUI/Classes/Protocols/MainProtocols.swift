//
//  MainProtocols.swift
//  TableauxUI
//
//  Created by Ernest DeFoy on 7/21/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import Foundation

public protocol Data {}
public protocol DataAdapter: Data {}
public protocol TableauDataAdapter: DataAdapter {
	var identifier: String { get }
	var constantHeight: Float? { get }
}

public protocol TableauDataAdapter2: TableauDataAdapter {
	var constantHeight: Float? { get }
}

public protocol UIMessage {}

public protocol Configurable {}
public protocol ConfigurableView: Configurable {}
public protocol ConfigurableCell: ConfigurableView {
	func configure(withAdapter adapter: TableauDataAdapter)
}
