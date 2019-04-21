//
//  Extensions.swift
//  URUN
//
//  Created by Jose M Arguinzzones on 2019-04-20.
//  Copyright © 2019 Jose M Arguinzzones. All rights reserved.
//

import Foundation

extension Double {
    func metersToMiles(places: Int ) -> Double {
        let divisor = pow(10.0, Double(places))
        return((self / 1609.34) * divisor).rounded() / divisor 
    }
}
