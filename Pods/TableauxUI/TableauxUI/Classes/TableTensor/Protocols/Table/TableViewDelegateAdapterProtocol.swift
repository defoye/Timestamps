//
//  TableViewDelegateAdapterProtocol.swift
//  TableauxUI
//
//  Created by Ernest DeFoy on 7/20/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import Foundation

public protocol TableViewDelegateAdapter {
	func heightForCell(inSection section: Int, inRow row: Int) -> Float?

	// headers
	func heightForHeader(inSection section: Int) -> Float?
	func headerViewDataAdapter(inSection section: Int) -> TableauDataAdapter?
	
	// footers
	func heightForFooter(inSection section: Int) -> Float?
	func footerViewDataAdapter(inSection section: Int) -> TableauDataAdapter?
	
	func headerViewIdentifier(forSection section: Int) -> String?
	func footerViewIdentifier(forSection section: Int) -> String?
}
