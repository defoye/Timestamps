//
//  RedCellViewData.swift
//  Timestamps
//
//  Created by Ernest DeFoy on 9/24/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import TableauxUI

public class RedCell: UITableViewCell {
	
}

extension RedCell: TableauCellProtocol {
	public func configure<T>(data: T) {
		self.backgroundColor = .red
	}
}

public struct RedCellData: TableauDataAdapter {
	public var constantHeight: Float? {
		return nil
	}
	
	public var identifier: String {
		return RedCell.reuseIdentifier
	}
}
