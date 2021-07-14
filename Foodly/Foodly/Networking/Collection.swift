//
//  Collection.swift
//  Foodly
//
//  Created by Decagon on 5.6.21.
//

import Foundation

enum Collection {
    case users
    case orderHistory
    case restaurants
    case deliveryPerson
    case menu
    case categories
    
    var identifier: String {
        switch self {
        case .users:
            return "users"
        case .orderHistory:
            return "orderHistory"
        case .restaurants:
            return "restaurants"
        case .deliveryPerson:
            return "deliveryPerson"
        case .menu:
            return "menu"
        case .categories:
            return "categories"
        }
    }
    
}
