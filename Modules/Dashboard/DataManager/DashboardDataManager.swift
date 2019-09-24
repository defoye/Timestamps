//
//  DashboardDataManager.swift
//  Timestamps
//
//  Created by Ernest DeFoy on 8/12/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import UIKit
import CoreData
import CoreDataTools

public class DashboardDataManager {
	
	let appContext: AppContext? = {
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
		return AppContext(context: appDelegate.persistentContainer.viewContext)
	}()
	
	public func addEntry(title: String) {
		guard let viewContext = appContext?.managedContext else { return }
		
		// TODO: Forced?
		let userEntity = NSEntityDescription.entity(forEntityName: DataEntity.EVENT, in: viewContext)!
		
		let event = NSManagedObject(entity: userEntity, insertInto: viewContext)
		
		let timestamp = Date()
		event.setValue(timestamp, forKey: DataKey.TIMESTAMP)
		event.setValue(title, forKey: DataKey.TITLE)
		
		appContext?.saveContext()
	}
	
	public func retrieveData() -> [Timestamp] {
		guard let objects = appContext?.fetchData(entity: DataEntity.EVENT, predicate: nil) else { fatalError() }
		
		return objects.map { (obj: NSManagedObject) -> Timestamp in
			return Timestamp(title: obj.value(forKey: DataKey.TITLE) as? String ?? nil,
							 date: obj.value(forKey: DataKey.TIMESTAMP) as? Date ?? nil)
		}
	}
	
	public func deleteTimestamp(title: String) {
		self.appContext?.deleteData(entity: DataEntity.EVENT, predicate: NSPredicate(format: "title = %@", title))
	}
}
