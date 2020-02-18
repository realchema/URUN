//
//  Location.swift
//  URUN
//
//  Created by Jose M Arguinzzones on 2019-04-22.
//  Copyright © 2019 Jose M Arguinzzones. All rights reserved.
//

import Foundation
import RealmSwift

class Location: Object {
    @objc dynamic public private(set) var latitude = 0.0
    @objc dynamic public private(set) var longitude = 0.0
    
    convenience init(latitude: Double, longitude: Double) {
        self.init()
        self.latitude = latitude
        self.longitude = longitude
    }
}
