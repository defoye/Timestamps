//
//  TableauxView.swift
//  TableauxUI
//
//  Created by Ernest DeFoy on 7/22/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import UIKit

public class TableauxView: UITableView {
	
}

extension TableauxView {
	public func registerCellTypes<T>(types: [T]) {
		for type in types {
			if let type = type as? UITableViewCell.Type {
				self.register(type, forCellReuseIdentifier: type.reuseIdentifier)
			}
			if let type = type as? UIView.Type {
				self.register(type, forCellReuseIdentifier: type.reuseIdentifier)
			}
		}
	}
	
	public func registerCellTypes(types: [TableauCell.Type]) {
		for type in types {
			self.register(type as UITableViewCell.Type, forCellReuseIdentifier: type.reuseIdentifier)
		}
	}
	
	public func registerCellTypes(types: [UITableViewCell.Type]) {
		for type in types {
			self.register(type, forCellReuseIdentifier: type.reuseIdentifier)
		}
	}
}
