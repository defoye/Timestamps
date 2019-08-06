//
//  TableTensor.swift
//  TableauxUI
//
//  Created by Ernest DeFoy on 7/20/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import Foundation

// Needs to be a class 
public class TableTensor {
	
	private var matrices: [TableMatrix]
	private var state: [TableMatrix]?
	
	public init(reservedMatrices: Int) {
		self.matrices = []
		self.state = nil
		let emptyTableMatrix = self.constructEmptyMatrix()
		self.matrices = Array.init(repeating: emptyTableMatrix, count: reservedMatrices)
	}
}

// MARK: - TableMatrix API
extension TableTensor {
	
	public func tableMatrixIndex(forSectionIndex section: Int) -> Int {
		var count: Int = 0
		for matrix in self.matrices {
			if section < matrix.numberSectionMatrices() {
				return count
			}
			count = count + 1
		}
		
		fatalError("TableMatrix index out of bounds")
	}
}

extension TableTensor: TableTensorInformationAdapter {
	public func tableMatrixIndexSet() -> IndexSet {
		let entireRange: ClosedRange<Int> = 0...self.numberOfTableMatrices() - 1
		return IndexSet(integersIn: entireRange)
	}
	
	
}

public protocol TableTensorStateAdapter {
	func setState()
	func resetState()
	func filteredStateFor(tableMatrixIndex index: Int, isIncluded: (Any) -> Bool)
}

// State
extension TableTensor: TableTensorStateAdapter {
	
	public func setState() {
		self.state = self.state ?? self.matrices
	}
	
	public func resetState() {
		self.state = nil
	}
	
	public func filteredStateFor(tableMatrixIndex index: Int, isIncluded: (Any) -> Bool) {
		self.setState()
		let tableMatrix: TableMatrix = self.getTableMatrix(atIndex: index)
		let filteredSectionMatrices = tableMatrix.filteredBodies(isIncluded: isIncluded)
		let filteredTableMatrix: TableMatrix = TableMatrix(tableSectionMatrices: filteredSectionMatrices)
		
		self.setMatrix(atIndex: index, to: filteredTableMatrix)
	}
}

// MARK: - Helpers
extension TableTensor {
	
	func numberOfSectionsInTableMatrices() -> Int {
		return self.matrices.reduce(0, { (sum, tableMatrix) -> Int in
			sum + tableMatrix.numberSectionMatrices()
		})
	}
	
	/**
	Returns one header. There is one header for each section.
	*/
	func getMatrixSectionHeader(forSection section: Int) -> Any? {
		let offsetIndex: Int = getOffsetIndex(forSectionIndex: section)
		let matrix: TableMatrix = getTableMatrix(forSectionIndex: section)
		
		return matrix.headerAt(sectionIndex: offsetIndex)
	}
	
	/**
	Returns an array. There is an array of models for each section.
	*/
	func getMatrixSectionBody(forSection section: Int) -> [Any] {
		let offsetIndex: Int = getOffsetIndex(forSectionIndex: section)
		let matrix: TableMatrix = getTableMatrix(forSectionIndex: section)
		
		return matrix.bodyAt(sectionIndex: offsetIndex)
	}
	
	/**
	Returns one footer. There is one footer for each section.
	*/
	func getMatrixSectionFooter(forSection section: Int) -> Any? {
		let offsetIndex: Int = getOffsetIndex(forSectionIndex: section)
		let matrix: TableMatrix = getTableMatrix(forSectionIndex: section)
		
		return matrix.footerAt(sectionIndex: offsetIndex)
	}
}

// MARK: - More helpers
extension TableTensor {
	
	private func getOffsetIndex(forSectionIndex sectionIndex: Int) -> Int {
		var sum: Int = 0
		
		for tableMatrix in self.getTableMatrixIterator() {
			if (sectionIndex < sum + tableMatrix.numberSectionMatrices()) {
				return sectionIndex - sum
			}
			sum = sum + tableMatrix.numberSectionMatrices()
		}
		
		fatalError("Section index out of bounds")
	}
	
	/**
	Gets the table matrix in terms of the total number of sections
	*/
	func getTableMatrix(forSectionIndex sectionIndex: Int) -> TableMatrix {
		var sum: Int = 0
		
		for tableMatrix in self.getTableMatrixIterator() {
			if (sectionIndex < sum + tableMatrix.numberSectionMatrices()) {
				return tableMatrix
			}
			sum = sum + tableMatrix.numberSectionMatrices()
		}
		
		fatalError("Section Index out of bounds")
	}
}

extension TableTensor {
	private func numberOfTableMatrices() -> Int {
		return self.state?.count ?? self.matrices.count
	}
	func getTableMatrix(atIndex index: Int) -> TableMatrix {
		return self.state?[index] ?? self.matrices[index]
	}
	
	func getTableMatrixSequence() -> EnumeratedSequence<[TableMatrix]> {
		return self.state?.enumerated() ?? self.matrices.enumerated()
	}
	
	func getTableMatrixIterator() -> IndexingIterator<[TableMatrix]> {
		return self.state?.makeIterator() ?? self.matrices.makeIterator()
	}
}

// MARK: - Destructive helpers
extension TableTensor {
	func setMatrix(atIndex index: Int, to tableMatrix: TableMatrix) {
		if self.state != nil {
			self.state?[index] = tableMatrix
		} else {
			self.matrices[index] = tableMatrix
		}
	}
	
	private func constructEmptyMatrix() -> TableMatrix {
		return TableMatrix(tableSectionMatrices: [])
	}
	
	private func destroyMatrix(atIndex index: Int) {
		self.matrices[index] = TableMatrix(tableSectionMatrices: [])
	}
}
