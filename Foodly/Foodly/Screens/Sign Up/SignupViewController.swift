import UIKit
import FirebaseAuth
import  FirebaseFirestore

class SignUpViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordTextFieldBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self        
    }
    
    func alertTextFields ( _ message: String) {
        let alert = UIAlertController(title: "One Moment", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    // MARK: - Validate TextFields
    func validateTextField() -> Bool {
        
        let fullname = fullNameTextField.text!.trimmingCharacters(in: .whitespaces)
        
        if fullNameTextField.text == "" {
            alertTextFields(Constant.fullnameAlertMSG)
        }
        
        if !fullname.hasWhiteSpace {
            alertTextFields(Constant.fullNameCheckAlert)
        }
        
        if emailTextField.text == "" {
            alertTextFields(Constant.emailAlertMSG)
        }
        
        if emailTextField.text != "" && !emailTextField.text!.isValidEmail {
            alertTextFields( Constant.invalidEmailAlertMSG)
        }
        
        if passwordTextField.text == "" {
            alertTextFields( Constant.passwordAlertMSG)
        }
        
        if isValidPassword(passwordTextField.text!) == false {
            alertTextFields(Constant.invalidPasswordAlertMSG)
        }
        return true
    }
    
    // MARK: - IBActions
    @IBAction func passwordTextFieldBtn(_ sender: Any) {
        passwordTextField.isSecureTextEntry.toggle()
        
        let imageName =  passwordTextField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
        passwordTextFieldBtn.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @IBAction func getStartedButton(_ sender: UIButton) {
        self.showIndicator(withTitle: "Creating your account")
        
        // MARK: - For Email and Password
        if validateTextField() {
            let address = ""
            let phone = ""
            if let email = emailTextField.text, let password = passwordTextField.text,
               let fullName = fullNameTextField.text {
                CreateUser.createUser(with: fullName, email, password, address, phone) { success in
                    if !success {
                        self.alertTextFields(Constant.networkErrorMSG)
                        self.hideIndicator()
                    } else {
                        print("Successfuly saved data")
                        self.hideIndicator()
                        
                        let alertController =
                            UIAlertController(title: "Done",
                                              message: "Account created successfully", preferredStyle: .alert)
                        let acceptAction =
                            UIAlertAction(title: "Accept", style: .default) { (_) -> Void
                                in
                                self.toLoginPage()
                            }
                        alertController.addAction(acceptAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @IBAction func toLoginScreen(_ sender: Any) {
        toLoginPage()
    }
    
    func toLoginPage () {
        guard let controller = storyboard?
                .instantiateViewController(identifier: "loginNav") as? UINavigationController else {return}
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true, completion: nil)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        print(updatedText,"updatedtext")
        return updatedText.count <= 25
    }
}
