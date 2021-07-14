//
//  PromoDiscount.swift
//  Foodly
//
//  Created by Decagon on 16.6.21.
//

import Foundation

fileprivate let promocodes = ["abd", "efg", "lmn", "123", "456" ]

class DicountedPrice {
    func getDiscountedPrice(_ promocode: String, _ initialCost: Int, _ dicount: Double) -> Double {
        var newCost = 0.0
        if promocodes.contains(promocode) {
            newCost = dicount * Double(initialCost)
        }else {
            newCost = Double(initialCost)
        }
        return newCost
    }
}
