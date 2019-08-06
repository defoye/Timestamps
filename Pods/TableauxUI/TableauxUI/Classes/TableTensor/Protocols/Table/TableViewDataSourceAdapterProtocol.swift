//
//  TableViewDataSourceAdapterProtocol.swift
//  TableauxUI
//
//  Created by Ernest DeFoy on 7/20/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import Foundation

public protocol TableViewDataSourceAdapter {
	func numberOfSections() -> Int
	func numberOfRows(inSection section: Int) -> Int
	
	// cells
	func cellViewDataAdapter(forSection section: Int, forRow row: Int) -> TableauDataAdapter?
	
	func cellIdentifier(forSection section: Int, forRow row: Int) -> String?
}

//public protocol CollectionViewDataSourceAdapter {
//	func numberOfSections() -> Int
//	func numberOfItems(inSection section: Int) -> Int
//
//	// cells
//	func sizeForItem(inSection section: Int, inRow row: Int) -> CGSize?
//	func cellViewDataAdapter(forSection section: Int, forRow row: Int) -> TableauDataAdapter?
//
//	func cellIdentifier(forSection section: Int, forRow row: Int) -> String?
//}
//
//import UIKit
//public class TableauxDataSource: UICollectionViewController {
//	public override func numberOfSections(in collectionView: UICollectionView) -> Int {
//		<#code#>
//	}
//	public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//		<#code#>
//	}
//	public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//		<#code#>
//	}
//}
//
//extension COllection: UICollectionViewDelegateFlowLayout {
//	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//		<#code#>
//	}
//}

