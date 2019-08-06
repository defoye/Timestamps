//
//  TableTensor+BucketAdapter1.swift
//  TableauxUI
//
//  Created by Ernest DeFoy on 7/20/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import Foundation

// Bucket adapter was made for the tableview
extension TableTensor: BucketAdapter1 {
	public func pour(sectionModels models: [[Any]], into index: Int) {
		let tableSectionMatrices = models.map { (adapters: [Any]) -> TableSectionMatrix in
			return TableSectionMatrix(header: nil, body: models, footer: nil)
		}
		let tableMatrix = TableMatrix(tableSectionMatrices: tableSectionMatrices)
		
		self.setMatrix(atIndex: index, to: tableMatrix)
	}
	
	public func pour(sectionModel model: [Any], into index: Int) {
		let tableSectionMatrix = TableSectionMatrix(header: nil, body: model, footer: nil)
		let tableMatrix = TableMatrix(tableSectionMatrices: [tableSectionMatrix])
		
		self.setMatrix(atIndex: index, to: tableMatrix)
	}
}
