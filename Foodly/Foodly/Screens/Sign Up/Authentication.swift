import UIKit
import FirebaseAuth
import FirebaseFirestore

struct CreateUser {
    static func createUser (with fullName: String, _ email: String, _ password: String, _ address: String, _ phone: String, createUserHandler: @escaping ((Bool) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let err = error, authResult == nil {
                print(err.localizedDescription)
                createUserHandler(false)
            } else {
                
                Firestore.firestore().collection("users").document(Auth.auth().currentUser!.uid).setData(["email": email, "fullName": fullName, "address": address, "phoneNumber": phone ]) { error in
                    guard let error = error else {  return}
                    print(error.localizedDescription)
                    createUserHandler(true)
                    
                }
            }
        }
        
    }
}
