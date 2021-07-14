//
//  Router.swift
//  Foodly
//
//  Created by Decagon on 5.6.21.
//

import Foundation
import FirebaseFirestore

typealias Parameter = [String: Any]
typealias NetworkRouterCompletion = (Result<QuerySnapshot?, Error>) -> Void

protocol FireBaseRouter {
    associatedtype Endpoint: FirestoreRequest
    func request(_ request: Endpoint, completion: @escaping NetworkRouterCompletion)
}

class Router<T: FirestoreRequest>: FireBaseRouter {
    
    func request(_ request: T, completion: @escaping NetworkRouterCompletion) {
        switch request.operations {
       
        case .read:
            
            read(request, completion: completion)
        case .create(let data):
            create(request, data: data, completion: completion)
        case .update(let data):
            update(request, data: data, completion: completion)
        case .delete:
            delete(request, completion: completion)
        case .query:
            query(request,completion:completion)
        }
    }
    private func query(_ request: T, completion: @escaping NetworkRouterCompletion) {
            
        request.collectionQuery?.addSnapshotListener { (snapshot, error) in
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                completion(.success(snapshot))
                
            }
        }
    }
    
    private func read(_ request: T, completion: @escaping NetworkRouterCompletion) {
            
        request.collectionReference?.addSnapshotListener { (snapshot, error) in
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                completion(.success(snapshot))
                
            }
        }
    }
    
    private func create(_ request: T, data: Parameter, completion: @escaping NetworkRouterCompletion) {
        request.collectionReference?.addDocument(data: data) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(nil))
            }
        }
    }
    
    private func update(_ request: T, data: Parameter, completion: @escaping NetworkRouterCompletion) {
        request.documentReference?.setData(data) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(nil))
            }
        }
    }
    
    private func delete(_ request: T, completion: @escaping NetworkRouterCompletion) {
        request.documentReference?.delete { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(nil))
            }
        }
    }
}
