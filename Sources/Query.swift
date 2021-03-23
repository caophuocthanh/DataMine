//
//  Query.swift
//  Storage
//
//  Created by Cao Phuoc Thanh on 3/18/21.
//  Copyright © 2021 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

internal extension Storage {
    
    /**
     Get all object with object type
     
     - parameter type: Object Type
     
     - returns: List Model Result (ZModel)
     */
    func all<T: Element>() -> [T] {
        return self.realm.objects(T.self).map{$0}.compactMap{$0}
    }
    
    /**
     Get object with id (primary key)
     
     - parameter type: Object type
     - parameter id:   id (primary key)
     
     - returns: Object (ZModel)
     */
    
    func get<T: Element>(id: Int) -> T? {
        let result = self.realm.objects(T.self)
        return result.filter("id == \(id)").first
    }
    
}
