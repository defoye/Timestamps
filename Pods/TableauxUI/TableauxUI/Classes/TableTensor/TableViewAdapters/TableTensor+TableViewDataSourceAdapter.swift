//
//  TableTensor+TableViewDataSourceAdapter.swift
//  TableauxUI
//
//  Created by Ernest DeFoy on 7/21/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import Foundation

// Trap the user since UITableViews at their core need to dequeue with an identifier.  Actually, there's probably a way around this.  But for now I trap.

// MARK: TableViewDataSourceAdapter
extension TableTensor: TableViewDataSourceAdapter {
	public func numberOfSections() -> Int {
		return self.numberOfSectionsInTableMatrices()
	}
	
	public func numberOfRows(inSection section: Int) -> Int {
		let body = self.getMatrixSectionBody(forSection: section)
		return body.count
	}
	
	// Optional
	
	public func cellViewDataAdapter(forSection section: Int, forRow row: Int) -> TableauDataAdapter? {
		return self.safeGetAdapter(section: section, row: row)
	}
	
	public func cellIdentifier(forSection section: Int, forRow row: Int) -> String? {
		return self.safeGetAdapter(section: section, row: row)?.identifier
	}
	
	// Helpers
	
	internal func safeGetAdapter(section: Int, row: Int) -> TableauDataAdapter? {
		let array = self.getMatrixSectionBody(forSection: section)
		// TODO Log.
		if row >= array.count {
			return nil
		}
		let data = array[row]
		
		// check for a height first
		if let adapter = data as? TableauDataAdapter2 {
			return adapter
		}
		// then check that it is at least a tableau cell
		if let adapter = data as? TableauDataAdapter {
			return adapter
		}
		
		fatalError("Need a Tableau adapter")
	}
}
