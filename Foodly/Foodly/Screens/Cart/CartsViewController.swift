//
//  CartsTableViewController.swift
//  Foodly
//
//  Created by Decagon on 16/06/2021.
//

import UIKit
import FirebaseRemoteConfig

class CartsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var deliveryUIView: UIView!
    @IBOutlet weak var promoUIView: UIView!
    @IBOutlet weak var continueUiView: UIButton!
    @IBOutlet weak var promoCodeTextField: UITextField!
    @IBOutlet weak var itemsTotal: UILabel!
    @IBOutlet weak var discountAmt: UILabel!
    @IBOutlet weak var taxAmt: UILabel!
    @IBOutlet weak var finalAmt: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let getPromoDiscount = RemoteConfigPromoCodes()
    
    var restName: String = ""
    var restDiscountValue: String = ""
    var discount: Float = 0
    var totalDiscount: Float = 0
    
    let remoteConfig = RemoteConfig.remoteConfig()
    let viewModel = CartViewModel()
    var initialAmt = [Float]()
    var finalTotalAmt = [Float]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CartTableViewCell", bundle: nil)
        viewModel.cartItems = viewModel.totalItems()
        tableView.register(nib, forCellReuseIdentifier: "CartTableViewCell")
        totalAmount()
        tableView.delegate = self
        tableView.dataSource = self
        promoCodeTextField.borderStyle = .none
        roundedCorners()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        getPromoDiscount.fetchValue()
        promoValues()
//        taxValue()
        

    }

    private func alertTextFields ( _ message: String) {
        let alert = UIAlertController(title: "One Moment", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        totalAmount()
        print("Confirming the printing \(getPromoDiscount.taxValue) and promoCode values: \(getPromoDiscount.promoCodes)")
    }
    
    fileprivate func promoValues () -> [String]{
        let result = getPromoDiscount.promoCodes.uppercased().components(separatedBy: " ")
        return result
    }
    
    
    func validatePromoCode () -> Bool {
        let validPromoCodes = promoValues()
        print(validPromoCodes)
        let inputCodes = promoCodeTextField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        if inputCodes == "" {
            alertTextFields(Constant.invalidPromoMSG1)
        }
        
        if !validPromoCodes.contains(inputCodes) {
            alertTextFields(Constant.invalidPromoMSG2)
            return false
        } else {
            return true
        }
    }

    func totalAmount() {
//        let calculateTax = Float(taxValue())! / 100
        for items in viewModel.cartItems {
            initialAmt.append(items.itemPrice)
        }

        let tax: Float = Float(String(format: "%.2f", (0.05 * initialAmt.reduce(0, +))))!
//        let tax: Float = Float(String(format: "%.2f", (calculateTax * initialAmt.reduce(0, +))))!
        itemsTotal.text = "$" + String(format: "%.2f", initialAmt.reduce(0, +))
        finalAmt.text = "$" + String(format: "%.2f", initialAmt.reduce(0, +) - totalDiscount + tax)
        discountAmt.text = "$\(totalDiscount)"
        discountAmt.text = "$" + String(format: "%.2f", totalDiscount)
        taxAmt.text = "$\(tax)"
        initialAmt.removeAll()
    }
    
    func totalAmountWithDiscount() {
//        let calculateTax = Float(taxValue())! / 100
        for items in viewModel.cartItems {
            initialAmt.append(items.itemPrice)
        }
        print("Cart: name: \(restName), discount: \(restDiscountValue)")
        discount = (Float(restDiscountValue) ?? 0) / 100
        totalDiscount = discount * initialAmt.reduce(0, +)
        
        let tax: Float = Float(String(format: "%.2f", (0.05 * initialAmt.reduce(0, +))))!
//        let tax: Float = Float(String(format: "%.2f", (calculateTax * initialAmt.reduce(0, +))))!
        itemsTotal.text = "$" + String(format: "%.2f", initialAmt.reduce(0, +))
        finalAmt.text = "$" + String(format: "%.2f", initialAmt.reduce(0, +) - totalDiscount + tax)
        discountAmt.text = "$\(totalDiscount)"
        discountAmt.text = "$" + String(format: "%.2f", totalDiscount)
        taxAmt.text = "$\(tax)"
        initialAmt.removeAll()
    }
    
    func roundedCorners() {
        deliveryUIView.layer.cornerRadius = 18
        promoUIView.layer.cornerRadius = 18
        continueUiView.layer.cornerRadius = 18
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cartItems.count
    }
    
    @IBAction func promoBtnPressed(_ sender: UIButton) {

        if validatePromoCode() {
            let alertController =
                UIAlertController(title: "Happy Shopping!",
                                  message: "Promo code is valid. Your discount is \(restDiscountValue)% off", preferredStyle: .alert)
            let acceptAction =
                UIAlertAction(title: "Accept", style: .default) {[weak self ] (_) -> Void
                    in
                    self?.reloadCartWithDiscount()
                }
            alertController.addAction(acceptAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    private func imageStringForRestaurant (check image: String) -> String {
        switch image {
        case "Conrad food":
            return "Group 43"
        case "Mr Biggs":
            return "Group 43"
        case "Mama Nkechi":
            return "Group 45"
        case "Black Fish":
            return "Group 45"
        case "Goichi Oniko":
            return "Group 46"
        case "SK Restro":
            return "Group 44"
        default:
        return "Group 43"
        }
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        let newStoryboard = UIStoryboard(name: "Confirmation", bundle: nil)
        let newController = newStoryboard
            .instantiateViewController(identifier: "ConfirmationViewController") as ConfirmationViewController
        newController.title = "Confirmation"
        
        var makeOrder = Food()
        makeOrder.name = restName
        makeOrder.image = imageStringForRestaurant(check: restName)
        makeOrder.items = "x \(viewModel.cartNumber.count) items"

        if let amount = finalAmt.text {
            makeOrder.price = amount
        }
        
        let request = OrderService()
        request.createOrder(with: makeOrder) { (result) in
            switch result {
            case .success: print("")
            case .failure(let error): print(error.localizedDescription)
            }
        }
        
        navigationController?.pushViewController(newController, animated: true)
        newController.modalTransitionStyle = .crossDissolve
        newController.modalPresentationStyle = .fullScreen
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
                .dequeueReusableCell(withIdentifier: "CartTableViewCell") as? CartTableViewCell else {
            return UITableViewCell()}
        cell.configureCart(with: viewModel.cartItems[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.cartItems.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

extension CartsViewController: CartTableViewCellDelegate {
    func addBtnTapped(sender: CartTableViewCell, on plus: Bool) {
        if plus == true {
            let indexPath = tableView.indexPath(for: sender)
            viewModel.cartNumber[indexPath!.row] = String(Int(viewModel.cartNumber[indexPath!.row])! + 1)
            reloadCart()
        } else {
            let indexPath = tableView.indexPath(for: sender)
                viewModel.cartNumber[indexPath!.row] = String(Int(viewModel.cartNumber[indexPath!.row])! - 1)
                if Int(viewModel.cartNumber[indexPath!.row])! >= 1 {
                reloadCart()
                } else if Int(viewModel.cartNumber[indexPath!.row])! == 0 {
                    viewModel.cartPrice.remove(at: indexPath!.row)
                    viewModel.cartNumber.remove(at: indexPath!.row)
                    viewModel.cartTitles.remove(at: indexPath!.row)
                    viewModel.cartImage.remove(at: indexPath!.row)
                    reloadCart()
                }
        }
    }
    
    func reloadCart() {
        viewModel.cartItems.removeAll()
        viewModel.cartItems = viewModel.totalItems()
        tableView.reloadData()
        totalAmount()
    }
    
    func reloadCartWithDiscount() {
        viewModel.cartItems.removeAll()
        viewModel.cartItems = viewModel.totalItems()
        tableView.reloadData()
        totalAmountWithDiscount()
    }
    
    
    func minusBtnTapped(sender: CartTableViewCell, on plus: Bool) {
    }
}
