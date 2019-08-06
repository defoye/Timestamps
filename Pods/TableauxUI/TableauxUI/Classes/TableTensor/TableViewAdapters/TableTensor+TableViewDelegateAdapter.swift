//
//  TableTensor+TableViewDelegateAdapter.swift
//  TableauxUI
//
//  Created by Ernest DeFoy on 7/20/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import Foundation

// Don't trap, user may not be using Header/Footer views.

extension TableTensor: TableViewDelegateAdapter {
	public func heightForCell(inSection section: Int, inRow row: Int) -> Float? {
		if let adapter = self.safeGetAdapter(section: section, row: row) as? TableauDataAdapter2 {
			return adapter.constantHeight
		}
		if let adapter = self.safeGetAdapter(section: section, row: row) {
			return adapter.constantHeight
		}
		
		return nil
	}
	
	public func heightForHeader(inSection section: Int) -> Float? {
		if let adapter = self.safeGetHeaderAdapter(section: section) as? TableauDataAdapter2 {
			return adapter.constantHeight
		}
		return nil
	}
	
	public func headerViewDataAdapter(inSection section: Int) -> TableauDataAdapter? {
		return self.safeGetHeaderAdapter(section: section)
	}
	
	public func heightForFooter(inSection section: Int) -> Float? {
		if let adapter = self.safeGetHeaderAdapter(section: section) as? TableauDataAdapter2 {
			return adapter.constantHeight
		}
		return nil
	}
	
	public func footerViewDataAdapter(inSection section: Int) -> TableauDataAdapter? {
		return self.safeGetFooterAdapter(section: section)
	}
	
	public func headerViewIdentifier(forSection section: Int) -> String? {
		return self.safeGetHeaderAdapter(section: section)?.identifier
	}
	
	public func footerViewIdentifier(forSection section: Int) -> String? {
		return self.safeGetFooterAdapter(section: section)?.identifier
	}
	
	
	// Helpers
	
	private func safeGetHeaderAdapter(section: Int) -> TableauDataAdapter? {
		let data = self.getMatrixSectionHeader(forSection: section)
		if let adapter = data as? TableauDataAdapter {
			return adapter
		}
		if let adapter = data as? TableauDataAdapter2 {
			return adapter
		}
		
		return nil
	}
	
	private func safeGetFooterAdapter(section: Int) -> TableauDataAdapter? {
		let data = self.getMatrixSectionFooter(forSection: section)
		if let adapter = data as? TableauDataAdapter {
			return adapter
		}
		if let adapter = data as? TableauDataAdapter2 {
			return adapter
		}
		
		return nil
	}

}
