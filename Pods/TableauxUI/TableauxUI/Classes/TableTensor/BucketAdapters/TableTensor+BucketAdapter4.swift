//
//  TableTensor+BucketAdapter4.swift
//  TableauxUI
//
//  Created by Ernest DeFoy on 7/20/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import Foundation

extension TableTensor: BucketAdapter4 {
	public func addItems(sectionItems items: [[Any]], atIndex index: Int) {
		let sections = items.map { (item: [Any]) -> TableSectionMatrix in
			TableSectionMatrix(header: nil, body: item, footer: nil)
		}
		let tableMatrix = self.getTableMatrix(atIndex: index)
		let combined = combine(firstTableSections: tableMatrix.tableSectionMatrices, secondTableSections: sections)
		self.setMatrix(atIndex: index, to: combined)
	}
	
	public func addItem(sectionItem item: [Any], atIndex index: Int) {
		let section = TableSectionMatrix(header: nil, body: item, footer: nil)
		let tableMatrix = self.getTableMatrix(atIndex: index)
		let combined = combine(firstTableSections: tableMatrix.tableSectionMatrices, secondTableSections: [section])
		self.setMatrix(atIndex: index, to: combined)
	}
	
	func combinedMatrix(atIndex index: Int, withSectionModels bodies: [[TableauDataAdapter]]) -> TableMatrix {
		let tableMatrix = self.getTableMatrix(atIndex: index)
		let newSections = bodies.map { (body: [TableauDataAdapter]) -> TableSectionMatrix in
			TableSectionMatrix(header: nil, body: body, footer: nil)
		}
		
		return combine(firstTableSections: tableMatrix.tableSectionMatrices, secondTableSections: newSections)
	}
	
	func combine(firstTableSections: [TableSectionMatrix], secondTableSections: [TableSectionMatrix]) -> TableMatrix {
		return TableMatrix(tableSectionMatrices: firstTableSections + secondTableSections)
	}
}
