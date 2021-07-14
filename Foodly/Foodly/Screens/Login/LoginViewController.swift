//
//  LoginViewController.swift
//  Foodly
//
//  Created by Decagon on 01/06/2021.
//

import UIKit
import FirebaseAuth

final class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordTextField: PaddingTextField!
    
    @IBOutlet weak var securedEyeBtn: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    private func setUpElements() {
        emailField.borderStyle = .none
        emailField.layer.cornerRadius = 20
        passwordTextField.borderStyle = .none
        passwordTextField.layer.cornerRadius = 20
    }
    
    @IBAction func didTapRegister(_ sender: Any) {
        transitionToSignUp()
    }
    
    @IBAction func eyeBtn(_ sender: Any) {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
        securedEyeBtn.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let email = emailField.text!
        let password = passwordTextField.text!
        
        if email == "" || password == "" {
            Alert.showIncompleteFormAlert(on: self)
        }
        self.showIndicator(withTitle: "Loading...")
        
        viewModel.loginUser(with: email, password: password) { [weak self] success in
            self?.hideIndicator()
            success ? self?.navigateToHome() : Alert.invalidEmailAlert(on: self!)
        }
    }
    
    func transitionToSignUp() {
        guard let controller = storyboard?
                .instantiateViewController(identifier:
                                            StoryboardID.Storyboard.signUpViewController) as?
                UINavigationController else {return}
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true, completion: nil)
    }
    
    func navigateToHome() {
                let newStoryboard = UIStoryboard(name: "HomeScreenStoryboard", bundle: nil)
                let newVC = newStoryboard.instantiateViewController(identifier: "homeScreenVC") as UITabBarController
                navigationController?.modalPresentationStyle = .fullScreen
                navigationController?.pushViewController(newVC, animated: true)
            }
    
    func alertTextFields ( _ message: String) {
        Alert.showIncompleteFormAlert(on: self)
    }
    
}
