//
//  DeliveryService.swift
//  Foodly
//
//  Created by Decagon on 22.6.21.
//

import Foundation

struct DeliveryService {
    let router = Router<DeliveryPersonApi>()
    
    func getDeliveryPeson(completion: @escaping NetworkRouterCompletion) {
        router.request(.getDeliveryPerson, completion: completion)
    }
}
