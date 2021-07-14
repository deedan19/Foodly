//
//  RestaurantService.swift
//  Foodly
//
//  Created by Decagon on 21.6.21.
//

import Foundation

struct RestaurantService {
    let router = Router<RestaurantAPI>()
    
    func getRestaurants(categoryName: String?, completion: @escaping NetworkRouterCompletion) {
        if let categoryName = categoryName {
            router.request(.filterCategory(categoryName), completion: completion)
        } else {
            router.request(.getRestaurants, completion: completion)
        }
        
    }
    
}
