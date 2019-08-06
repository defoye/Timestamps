//
//  TableMatrixStructs.swift
//  TableauxUI
//
//  Created by Ernest DeFoy on 7/20/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import Foundation

public struct TableSectionMatrix {
	let header: Any?
	let body: [Any]
	let footer: Any?
	
	public func data(atIndex index: Int) -> Any {
		if index >= body.count {
			fatalError("Index out of range")
		}
		
		return body[index]
	}
}

public struct TableMatrix {
	let tableSectionMatrices: [TableSectionMatrix]
	
	public func numberSectionMatrices() -> Int {
		return self.tableSectionMatrices.count
	}
	
	public func headerAt(sectionIndex: Int) -> Any? {
		return self.tableSectionMatrices[sectionIndex].header
	}
	public func bodyAt(sectionIndex: Int) -> [Any] {
		return self.tableSectionMatrices[sectionIndex].body
	}
	public func footerAt(sectionIndex: Int) -> Any? {
		return self.tableSectionMatrices[sectionIndex].footer
	}
	
	public func filteredBodies(isIncluded: (Any) -> Bool) -> [TableSectionMatrix] {
		return self.tableSectionMatrices.map({ (tableSectionMatrix: TableSectionMatrix) -> TableSectionMatrix in
			return TableSectionMatrix(header: tableSectionMatrix.header,
									  body: tableSectionMatrix.body.filter(isIncluded),
									  footer: tableSectionMatrix.footer)
		})
	}
	
//	public mutating func appendMatrices(matrices: [TableSectionMatrix]) {
//		self.tableSectionMatrices = self.tableSectionMatrices + matrices
//	}
}
