//
//  ViewAdapter.swift
//  Timestamps
//
//  Created by Ernest DeFoy on 8/4/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import TableauxUI

public class ViewAdapter {
	let tableau: Tableau
	
	public init() {
		self.tableau = Tableau(numberReservedTableaux: 1)
		
//		self.tableau.bucketAdapter1().pour(sectionModel: [RedCellData()], into: 0)
		self.tableau.bucketAdapter1().pour(sectionModel: [TimestampCellViewData()], into: 0)
	}
}
