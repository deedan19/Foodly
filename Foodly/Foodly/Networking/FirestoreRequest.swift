//
//  FirestoreRequest.swift
//  Foodly
//
//  Created by Decagon on 5.6.21.
//

import Foundation
import FirebaseFirestore

protocol FirestoreRequest {
    var operations: Operations { get }
    var documentReference: DocumentReference? { get }
    var collectionReference: CollectionReference? { get }
    var baseDocumentReference: DocumentReference? { get }
    var collectionQuery: Query? { get }
}

extension FirestoreRequest {
    var collectionQuery: Query? { return nil }//default implementation for a protocol
}
