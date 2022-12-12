//
//  Todo+CoreDataProperties.swift
//  YashTodo project
//
//  Created by Felix IT on 17/11/22.
//  Copyright © 2022 Felix IT. All rights reserved.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var title: String?
    @NSManaged public var createdAt: Int64

}
