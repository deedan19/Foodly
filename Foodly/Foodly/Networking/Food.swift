//
//  Food.swift
//  Foodly
//
//  Created by Decagon on 8.6.21.
//

import Foundation

struct Food {
    var name = ""
    var price = ""
    var items = ""
    var image = ""
}
extension Food: RequestParameter {
    var asParameter: Parameter {
        return [ "cost": price, "imageName": image, "items": items, "name": name ]
    }
}
