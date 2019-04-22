//
//  Person.swift
//  URUN
//
//  Created by Jose M Arguinzzones on 2019-04-22.
//  Copyright © 2019 Jose M Arguinzzones. All rights reserved.
//

import Foundation
import RealmSwift

class Person: Object{
    @objc dynamic public private(set) var id = ""
    @objc dynamic public private(set) var password = ""


override class func primaryKey() ->String {
    return "id"
}

override class func indexedProperties() -> [String] {
    return  ["password" ]
}
convenience init(password: String) {
    self.init()
    self.id = UUID().uuidString.lowercased()
    self.password = password
   
}
}
