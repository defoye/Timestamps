//
//  TableauViewAdapter.swift
//  TableauxUI
//
//  Created by Ernest DeFoy on 7/21/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import Foundation

public class TableauViewAdapter {
	
	let tableau: Tableau
	
	init(reservedMatrices: Int) {
		self.tableau = Tableau(numberReservedTableaux: reservedMatrices)
	}
	
	func apply(filter: ((Any) -> Bool), onIndexSet indexSet: IndexSet) {
		for i in indexSet.makeIterator() {
			self.tableau.stateAdapter().filteredStateFor(tableMatrixIndex: i, isIncluded: filter)
		}
	}
}
