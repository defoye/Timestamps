//
//  TableauProtocols.swift
//  TableauxUI
//
//  Created by Ernest DeFoy on 7/21/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import UIKit

public protocol ReusableView {
	static var reuseIdentifier: String { get }
}

extension ReusableView {
	public static var reuseIdentifier: String {
		return String(describing: self)
	}
}
public protocol DataConfigurable {
	func configure<T>(data: T)
}

public protocol TableauCellProtocol: DataConfigurable {}
//extension UITableViewCell: ReusableView {}
extension UIView: ReusableView {}

public protocol CellDelegateAdapter {
	func addDelegateAdapter(delegate: TableauxDataSourceDelegateAdapter)
}

public protocol TableauCellDelegateAdapter: CellDelegateAdapter {}
public protocol TableauxDataSourceDelegateAdapter: class {
	func relay(message: UIMessage)
}


