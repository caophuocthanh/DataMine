//
//  File.swift
//  
//
//  Created by Cao Phuoc Thanh on 8/27/20.
//

import Foundation
import RealmSwift

public class Model: Object {
    
    @objc public dynamic var id: String = ""
    
    public convenience init(id: String) {
        self.init()
        self.id = id
    }
}