//
//  OrderService.swift
//  Foodly
//
//  Created by mac on 01/07/2021.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel {
    
    var fullName = ""
    var userAddress = ""
    var phoneNumber = ""
    var email = ""
    var notificationCompletion: (() -> Void)?
    
    func getProfileDetails() {
            let docId = Auth.auth().currentUser?.uid
            let docRef = Firestore.firestore().collection("/users").document("\(docId!)")
            docRef.getDocument {(document, error) in
            
                if let document = document, document.exists, error == nil {
                    let docData = document.data()
                    let userEmail = docData!["email"] as? String ?? "Email???"
                    let userFullName = docData!["fullName"] as? String ?? "Full name???"
                    let address = docData!["address"] as? String ?? "Edit address"
                    let phoneNumber = docData!["phoneNumber"] as? String ?? "Add Phone Number"
                    self.userAddress.append(address)
                    self.phoneNumber.append(phoneNumber)
                    self.email.append(userEmail)
                    self.fullName.append(userFullName)
                   
                }
                self.notificationCompletion?()
            }
        }
        
    func updateProfile(view: UIViewController, _ email: String, _ fullName: String,
                       _ address: String, _ phoneNumber: String) {
            let docId = Auth.auth().currentUser?.uid
            Firestore.firestore().collection("users").document(docId!).setData(
                ["email": email, "fullName": fullName, "address": address, "phoneNumber": phoneNumber]) { (error) in
                if error != nil {
                    print("failure")
                    Alert.showBasicAlert(on: view, with: "Error",
                                         message: "There was an error saving your profile. Please try again.")
                } else {
                    Alert.showBasicAlert(on: view, with: "Success", message: "Profile Updated Successfully")
                    print("success")
                    
                    }
            }
        }
}
