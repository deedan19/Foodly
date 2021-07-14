//
//  ProfileViewController.swift
//  Foodly
//
//  Created by mac on 01/07/2021.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    var database = Firestore.firestore()
    var addressChanged: String?
    var phoneNumberChanged: String?

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var phoneNo: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    var profileVM = ProfileViewModel()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = nil
        logoutBtn.layer.cornerRadius = logoutBtn.frame.size.height / 3
        let barButton = UIBarButtonItem(customView: button)
            navigationItem.rightBarButtonItem = barButton
        button.addTarget(self, action: #selector(didTapEdit), for: .touchUpInside)
        button.setTitle("Edit", for: .normal)
        
        profileVM.getProfileDetails()
        profileVM.notificationCompletion = {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.nameLbl.text = self.profileVM.fullName
                self.phoneNo.text = self.profileVM.phoneNumber
                self.address.text = self.profileVM.userAddress
            }
        }
    }
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 60, height: 0)
        return button
    }()
    
    @IBAction func didTapSwitch(_ sender: UISwitch) {
        var notifications = false
        if sender.isOn {
            notifications  = true
        } else {
            notifications = false
        }
    }
    
    @objc func didTapEdit() {
        
        button.title(for: .normal) == "Done" ? saveButton() : editButton()
    }
    
    func editButton() {
        phoneNo.isEnabled = true
        phoneNo.becomeFirstResponder()
        address.isEnabled = true
        
        addressChanged = address.text
        phoneNumberChanged = phoneNo.text
        
        button.setTitle("Done", for: .normal)
    }
    
    func saveButton() {
        
        guard phoneNumberChanged != nil,
            addressChanged != nil else {
            fatalError("")
        }
        
        button.setTitle("Edit", for: .normal)
        phoneNo.resignFirstResponder()
        address.resignFirstResponder()
        phoneNo.isEnabled = false
        address.isEnabled = false
        
        if phoneNo.text != phoneNumberChanged || address.text! != addressChanged {
            profileVM.updateProfile(view: self, profileVM.email, profileVM.fullName,
                                    address.text!, phoneNo.text!)
        }
    }
    
    @IBAction func didTapLogout(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch {
            Alert.showBasicAlert(on: self, with: "Error",
                                 message: "There was an error logging you out. Please try again.")
        }
    }
}
