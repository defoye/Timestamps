//
//  TableTensor+PaintAdapter.swift
//  TableauxUI
//
//  Created by Ernest DeFoy on 7/22/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import Foundation

extension TableTensor: PaintAdapter {
	public func paint(sectionModel model: [Any], at index: Int) {
		let tableSectionMatrix = TableSectionMatrix(header: nil, body: model, footer: nil)
		let tableMatrix = TableMatrix(tableSectionMatrices: [tableSectionMatrix])
		
		self.setMatrix(atIndex: index, to: tableMatrix)
	}
	
	public func paint(sectionModels models: [[Any]], at index: Int) {
		let tableSectionMatrices = models.map { (adapters: [Any]) -> TableSectionMatrix in
			return TableSectionMatrix(header: nil, body: models, footer: nil)
		}
		let tableMatrix = TableMatrix(tableSectionMatrices: tableSectionMatrices)
		
		self.setMatrix(atIndex: index, to: tableMatrix)
	}
}


