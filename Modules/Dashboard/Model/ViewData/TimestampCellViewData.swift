//
//  TimestampCellViewData.swift
//  Timestamps
//
//  Created by Ernest DeFoy on 8/4/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import TableauxUI

public struct TimestampCellViewData: TableauDataAdapter, TableauDataAdapter2 {
	public var constantHeight: Float? = 175
	public var identifier: String = TimestampCell.reuseIdentifier
	public let timestamp: Timestamp
	
	public init(timestamp: Timestamp) {
		self.timestamp = timestamp
	}
}
