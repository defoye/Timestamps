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
	
	public func daysSince() -> Int? {
		let calendar = Calendar.current
		
		// Replace the hour (time) of both dates with 00:00
		let date1 = calendar.startOfDay(for: timestamp.date ?? Date())
		let date2 = calendar.startOfDay(for: Date())
		
		let components = calendar.dateComponents([.day], from: date1, to: date2)
		
		return components.day ?? nil
	}
}
