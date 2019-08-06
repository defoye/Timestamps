//
//  BucketAdapterProtocols.swift
//  TableauxUI
//
//  Created by Ernest DeFoy on 7/20/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import Foundation

public struct BucketContent {
	let headers: [TableauDataAdapter?]?
	let bodies: [[TableauDataAdapter]]
	let footers: [TableauDataAdapter?]?
}

public protocol BucketAdapter {
	func bucketIndex(forSectionIndex sectionIndex: Int) -> Int
	func model(atModelIndex modelIndex: (Int,Int)) -> TableauDataAdapter?
}

public protocol BucketAdapter1 {
	func pour(sectionModel model: [Any], into index: Int)
	func pour(sectionModels models: [[Any]], into index: Int)
}

public protocol PaintAdapter {
	func paint(sectionModel model: [Any], at index: Int)
	func paint(sectionModels models: [[Any]], at index: Int)
}

public protocol BucketAdapter4 {
	func addItems(sectionItems items: [[Any]], atIndex index: Int)
	func addItem(sectionItem item: [Any], atIndex index: Int)
}
