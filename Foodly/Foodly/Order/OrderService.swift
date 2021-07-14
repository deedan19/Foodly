//
//  OrderService.swift
//  Foodly
//
//  Created by Decagon on 8.6.21.
//

import Foundation

struct OrderService {
    let router = Router<OrderAPI>()
    func createOrder(with food: Food, completion: @escaping NetworkRouterCompletion) {
        router.request(.createFoodOrder(items: food), completion: completion)
    }
    
    func getOrderHistory(completion: @escaping NetworkRouterCompletion) {
        router.request(.getFoodOrderHistory, completion: completion)
    }
    
    func updateOrder(for orderId: String, food: Food, completion: @escaping NetworkRouterCompletion) {
        router.request(.updateFoodOrder(userId: orderId, items: food), completion: completion)
    }
}
