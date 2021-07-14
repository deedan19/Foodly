//
//  MealService.swift
//  Foodly
//
//  Created by Decagon on 25/06/2021.
//

import Foundation
struct MealService {
    let router = Router<MealsAPI>()
    
    func getMeals(restaurantId: String, completion: @escaping NetworkRouterCompletion) {
        router.request(.getMeals(restaurantId: restaurantId), completion: completion)
    }
    
}
