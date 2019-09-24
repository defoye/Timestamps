//
//  DashboardViewAdapter.swift
//  Timestamps
//
//  Created by Ernest DeFoy on 8/4/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import TableauxUI

public class DashboardViewAdapter {
	let tableau: Tableau
	let dataManager: DashboardDataManager
	
	public init() {
		self.tableau = Tableau(numberReservedTableaux: 1)
		self.dataManager = DashboardDataManager()
	}
	
	public func buildTimestampSection() {
		let timestamps: [Timestamp] = dataManager.retrieveData()
		
		let viewData: [TimestampCellViewData] = timestamps.map { (ts: Timestamp) -> TimestampCellViewData in
			return TimestampCellViewData(timestamp: ts)
		}
		
		self.tableau.bucketAdapter1().pour(sectionModel: viewData, into: 0)
	}
}
