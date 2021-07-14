//
//  CategoryAPI.swift
//  Foodly
//
//  Created by Decagon on 05/07/2021.
//

import Foundation
import FirebaseFirestore


enum CategoryAPI {
    case getCategories
}

extension CategoryAPI: FirestoreRequest {
    var operations: Operations {
        switch self {
        case .getCategories:
            return .read
        }
    }
    
    var documentReference: DocumentReference? {
        return nil
    }
    
    var collectionReference: CollectionReference? {
        switch self {
        case .getCategories:
            return Firestore.firestore().collection(Collection.categories.identifier)
        }
    }
    
    var baseDocumentReference: DocumentReference? {
        return nil
    }
}
