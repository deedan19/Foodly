//
//  FireNetworking.swift
//  Foodly
//
//  Created by Decagon on 31.5.21.
//

import Foundation
import Firebase
import FirebaseFirestore

class FireNetworking {
    
    let userReference = Firestore.firestore().collection("users")
    
    func create() {
        let parameters: [String: Any] = ["firstName": "Obi", "lastName": "Ugoh"]
        userReference.addDocument(data: parameters)
    }
    
    func read() {
        userReference.addSnapshotListener { (snapshot, _) in
            guard let snapshot = snapshot else { return }
            for document in snapshot.documents {
                print(document.data())
            }
        }
    }
    
    func update() {
        userReference.document("G6dvsOr0ATjwOPX9LW4G").setData(["firstName": "Halir", "lastName": "AbdulAzeez"])
    }
    
    func delete() {
        userReference.document("LMaj2zzdkvdrLSP0CJZ7").delete()
    }
}
