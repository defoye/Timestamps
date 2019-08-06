//
//  Tableau.swift
//  TableauxUI
//
//  Created by Ernest DeFoy on 7/20/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import Foundation

public protocol ModelController {}
public protocol TableViewModelControllerProtocol: ModelController {}

public struct TableViewPort {
	let dataSourceAdapter: (() -> TableViewDataSourceAdapter)
	let delegateAdapter: (() -> TableViewDelegateAdapter)
}

public struct Tableau {
	
	// Tensor Adapters
	public let stateAdapter: (() -> TableTensorStateAdapter)
	public let informationAdapter: (() -> TableTensorInformationAdapter)
	
	// Custom Adapters
	public let bucketAdapter1: (() -> BucketAdapter1)
	public let bucketAdapter4: (() -> BucketAdapter4)
	public let paintAdapter: (() -> PaintAdapter)

	// UITableViewAdapters
	public let dataSourceAdapter: (() -> TableViewDataSourceAdapter)
	public let delegateAdapter: (() -> TableViewDelegateAdapter)
	
	public init(numberReservedTableaux: Int) {
		let tensor: TableTensor = TableTensor(reservedMatrices: numberReservedTableaux)
		
		self.stateAdapter = { return tensor as TableTensorStateAdapter }
		self.informationAdapter = { return tensor as TableTensorInformationAdapter }
		self.bucketAdapter1 = { return tensor as BucketAdapter1 }
		self.bucketAdapter4 = { return tensor as BucketAdapter4 }
		self.paintAdapter = { return tensor as PaintAdapter }
		self.dataSourceAdapter = { return tensor as TableViewDataSourceAdapter }
		self.delegateAdapter = { return tensor as TableViewDelegateAdapter }
	}
	
	public func apply(filter: ((Any) -> Bool), onIndexSet indexSet: IndexSet) {
		for i in indexSet.makeIterator() {
			self.stateAdapter().filteredStateFor(tableMatrixIndex: i, isIncluded: filter)
		}
	}
}
