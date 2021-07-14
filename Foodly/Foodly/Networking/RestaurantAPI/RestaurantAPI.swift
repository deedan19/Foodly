//
//  RestaurantApi.swift
//  Foodly
//
//  Created by Decagon on 21.6.21.
//

import Foundation
import FirebaseFirestore

enum RestaurantAPI {
    case getRestaurants
    case filterCategory(String)
}


extension RestaurantAPI: FirestoreRequest {
    var operations: Operations {
        switch self {
        case .getRestaurants:
            return .read
        case .filterCategory(_):
            return.query
        }
    }
    
    var baseDocumentReference: DocumentReference? {
        return nil 
    }
    
    var documentReference: DocumentReference? {
        return nil
    }
    
    var collectionReference: CollectionReference? {
        switch self {
        case .getRestaurants, .filterCategory:
            return Firestore.firestore().collection(Collection.restaurants.identifier)
        }
    }
    
    var collectionQuery: Query? {
        switch self {
        case .getRestaurants:
            return nil
        case .filterCategory(let category):
            return collectionReference?.whereField("mealType", isEqualTo:category)
        }
    }
    
}
