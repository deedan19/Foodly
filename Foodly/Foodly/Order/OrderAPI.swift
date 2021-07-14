//
//  OrderAPI.swift
//  Foodly
//
//  Created by Decagon on 7.6.21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

enum OrderAPI {
    case createFoodOrder(items: RequestParameter)
    case getFoodOrderHistory
    case updateFoodOrder(userId: String, items: RequestParameter)
}

extension OrderAPI: FirestoreRequest {
    var operations: Operations {
        switch self {
        case .createFoodOrder(let food):
            return .create(data: food.asParameter)
        case .getFoodOrderHistory:
            return .read
        case .updateFoodOrder(_, let food):
            return .update(data: food.asParameter)
        }
    }
    
    var baseDocumentReference: DocumentReference? {
        guard let userID = Auth.auth().currentUser?.uid else { return nil }
        return Firestore.firestore().collection(Collection.users.identifier).document(userID)
    }
    
    var collectionReference: CollectionReference? {
        switch self {
        case .createFoodOrder:
            return baseDocumentReference?.collection(Collection.orderHistory.identifier)
        case .getFoodOrderHistory:
            return baseDocumentReference?.collection(Collection.orderHistory.identifier)
        case .updateFoodOrder( _, items: _):
            return nil
        }
    }
    
    var documentReference: DocumentReference? {
        switch self {
        case .createFoodOrder:
            return baseDocumentReference
        case .getFoodOrderHistory:
            return baseDocumentReference?.collection(Collection.orderHistory.identifier).document()
        case .updateFoodOrder( let orderId, _):
            return baseDocumentReference?.collection(Collection.orderHistory.identifier).document(orderId)
        }
    }
    
}
