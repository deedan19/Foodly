//
//  CategoryService.swift
//  Foodly
//
//  Created by Decagon on 05/07/2021.
//

import Foundation

struct CategoryService {
    let router = Router<CategoryAPI>()
    
    func getCategory(completion: @escaping NetworkRouterCompletion) {
        router.request(.getCategories, completion: completion)
    }
    
}
