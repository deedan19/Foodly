//
//  MealsAPI.swift
//  Foodly
//
//  Created by Decagon on 25/06/2021.
//
import Foundation
import FirebaseFirestore
enum MealsAPI {
    case getMeals(restaurantId: String)
}
extension MealsAPI: FirestoreRequest {
    var operations: Operations {
        switch self {
        
        case .getMeals:
            return .read
        }
    }
    
    var baseDocumentReference: DocumentReference? {
        return Firestore.firestore().collection(Collection.restaurants.identifier).document()
    }
    
    var documentReference: DocumentReference? {
        switch self {
        case .getMeals:
            return baseDocumentReference?.collection(Collection.restaurants.identifier).document()
        }
    }
    
    var collectionReference: CollectionReference? {
        switch self {
            
        case .getMeals(restaurantId: let restaurantId):
            return Firestore.firestore().collection(Collection.restaurants.identifier).document(restaurantId).collection(Collection.menu.identifier)
        }
    }
    
}
//
//let pole = MealService()
//pole.getMeals(restaurantId: "conrad") {(result) in
