//
//  Model+JSON.swift
//  Storage
//
//  Created by Cao Phuoc Thanh on 4/7/21.
//  Copyright © 2021 Cao Phuoc Thanh. All rights reserved.
//

import Foundation

public extension Model {
    
    var dictionary: [String: Any] {
        var json: [String: Any] = [:]
        let mirrored_object = Mirror(reflecting: self)
        for element in mirrored_object.children {
            if let label = element.label {
                json[label] = element.value
            }
        }
        for element in mirrored_object.superclassMirror!.children {
            if let label = element.label {
                json[label] = element.value
            }
        }
        return json.removeNull().removeKeys(["_thread", "_updated_at", "_uid", "_created_at"])
    }
    
}

private extension Dictionary {
    
    func removeKeys(_ keys: [String]) -> Dictionary {
        let mainDict = NSMutableDictionary.init(dictionary: self)
        for _dict in mainDict {
            if let key = _dict.key as? String, keys.contains(key) {
                mainDict.removeObject(forKey: _dict.key)
            }
        }
        return mainDict as! Dictionary<Key, Value>
    }
    
    func removeNull() -> Dictionary {
        let mainDict = NSMutableDictionary.init(dictionary: self)
        for _dict in mainDict {
            if _dict.value is NSNull {
                mainDict.removeObject(forKey: _dict.key)
            }
            if _dict.value is NSDictionary {
                let test1 = (_dict.value as! NSDictionary).filter({ $0.value is NSNull }).map({ $0 })
                let mutableDict = NSMutableDictionary.init(dictionary: _dict.value as! NSDictionary)
                for test in test1 {
                    mutableDict.removeObject(forKey: test.key)
                }
                mainDict.removeObject(forKey: _dict.key)
                mainDict.setValue(mutableDict, forKey: _dict.key as? String ?? "")
            }
            if _dict.value is NSArray {
                let mutableArray = NSMutableArray.init(object: _dict.value)
                for (index,element) in mutableArray.enumerated() where element is NSDictionary {
                    let test1 = (element as! NSDictionary).filter({ $0.value is NSNull }).map({ $0 })
                    let mutableDict = NSMutableDictionary.init(dictionary: element as! NSDictionary)
                    for test in test1 {
                        mutableDict.removeObject(forKey: test.key)
                    }
                    mutableArray.replaceObject(at: index, with: mutableDict)
                }
                mainDict.removeObject(forKey: _dict.key)
                mainDict.setValue(mutableArray, forKey: _dict.key as? String ?? "")
            }
        }
        return mainDict as! Dictionary<Key, Value>
    }
}

