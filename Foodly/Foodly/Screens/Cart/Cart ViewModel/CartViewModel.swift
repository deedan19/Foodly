//
//  CartViewModel.swift
//  Foodly
//
//  Created by Decagon on 16/06/2021.
//

import UIKit

class CartViewModel {
    var itemCount = 0
    var cartItems = [CartModel]()
    var cartTitles = [String]()
    var cartPrice = [Float]()
    var cartImage = [UIImage]()
    var cartNumber = [String]()
    var totalAmt = [Float]()
    
    func totalItems() -> [CartModel] {
        for itemAtRow in 0 ..< cartPrice.count {
            cartItems.append(CartModel(itemName: cartTitles[itemAtRow],
                                       itemPrice: Float(String(format: "%.2f",
                                        cartPrice[itemAtRow] * Float(cartNumber[itemAtRow])!))!,
                                       itemImage: cartImage[itemAtRow],
                                       itemNumber: cartNumber[itemAtRow]))
        }
        return cartItems
    }
    
    init() {
        self.cartItems = totalItems()
    }
}
