//
//  PlacesMO+CoreDataProperties.swift
//  Travel-App
//
//  Created by Enoch Ko on 3/11/17.
//  Copyright © 2017 asu. All rights reserved.
//

import Foundation
import CoreData


extension PlacesMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlacesMO> {
        return NSFetchRequest<PlacesMO>(entityName: "Places");
    }

    @NSManaged public var name: String?
    @NSManaged public var picture: NSData?
    @NSManaged public var small_description: String?

}
