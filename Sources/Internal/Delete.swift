//
//  Delete.swift
//  Storage
//
//  Created by Cao Phuoc Thanh on 3/18/21.
//  Copyright © 2021 Cao Phuoc Thanh. All rights reserved.
//

import Foundation

internal extension Storage {

    func delete<T: Object>(_ model: T) throws {
        try self.realm.write {
            self.realm.delete(model)
        }
    }
    
}
