//
//  TableauxDelegate.swift
//  TableauxUI
//
//  Created by Ernest DeFoy on 7/22/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import UIKit

public class TableauxDelegate: NSObject {
	let delegateAdapter: (() -> TableViewDelegateAdapter)
	var selectionEndpoint: ((_ section: Int, _ row: Int) -> Void)?

	init(tableau: Tableau) {
		self.delegateAdapter = { return tableau.delegateAdapter() }
		super.init()
	}
	init(tableau: Tableau, tableauxUIView: TableauxView) {
		self.delegateAdapter = { return tableau.delegateAdapter() }
		super.init()
		tableauxUIView.delegate = self
	}
	init(tableau: Tableau, tableView: UITableView) {
		self.delegateAdapter = { return tableau.delegateAdapter() }
		super.init()
		tableView.delegate = self
	}
}

extension TableauxDelegate: UITableViewDelegate {
	
	public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if let height = delegateAdapter().heightForCell(inSection: indexPath.section, inRow: indexPath.row) {
			return CGFloat(height)
		}
		
		return UITableView.automaticDimension
	}
	
	public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard let identifier = delegateAdapter().headerViewIdentifier(forSection: section) else { return nil }
		guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? TableauCellProtocol else { return nil }
		
		let data = delegateAdapter().headerViewDataAdapter(inSection: section)
		
		view.configure(data: data)
		
		if let view = view as? UIView {
			return view
		}
		
		return nil
	}
	
	public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		guard let identifier = delegateAdapter().footerViewIdentifier(forSection: section) else { return nil }
		guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? TableauCellProtocol else { return nil }
		
		let data = delegateAdapter().footerViewDataAdapter(inSection: section)
		
		view.configure(data: data)
		
		if let view = view as? UIView {
			return view
		}
		
		return nil
	}
	
	public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return CGFloat(delegateAdapter().heightForFooter(inSection: section) ?? 0)
	}
	
	public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return CGFloat(delegateAdapter().heightForHeader(inSection: section) ?? 0)
	}
	
	public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		selectionEndpoint?(indexPath.section,indexPath.row)
	}
}
