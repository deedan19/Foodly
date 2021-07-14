//
//  ConfirmationViewController.swift
//  Foodly
//
//  Created by Decagon on 14.6.21.
//

import UIKit

class ConfirmationViewController: UIViewController {
    
    @IBOutlet weak var deliveryPersonImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var checkMarkView: UIView!
    @IBOutlet weak var purpleDotView: UIView!
    @IBOutlet weak var phoneImageView: UIView!
    @IBOutlet weak var deliveryPersonImageView: UIView!
    @IBOutlet weak var confirmationDetailsView: UIView!
    
    let viewModel = DeliveryViewModel()
    var phoneNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.confirmationDetailsCompletion = {[weak self] in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.nameLabel.text = self.viewModel.name
                self.timeLabel.text = self.viewModel.time
                self.deliveryPersonImage.image = UIImage(named: self.viewModel.imageName)
            }
            self.phoneNumber = self.viewModel.phone

        }
            }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        self.navigationController!.popToRootViewController(animated: true)
    }
    
    @IBAction func callButton(_ sender: UIButton) {
        if let url = URL(string: "tel://\(phoneNumber)"),
           UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.canOpenURL(url)
            }
        } else {
            let alert = UIAlertController(title: "Oops🤭", message: "Unable to make call.",
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func setUpView() {
        confirmationDetailsView.layer.cornerRadius = 23
        phoneImageView.layer.cornerRadius = 14
        deliveryPersonImageView.layer.cornerRadius = 14
        checkMarkView.layer.cornerRadius = 10
        purpleDotView.layer.cornerRadius = 10
        doneButton.layer.cornerRadius = 20
    }
}
