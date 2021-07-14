//
//  MoreDetailsTableViewController.swift
//  Foodly
//
//  Created by Decagon on 22/06/2021.
//

import UIKit

class MoreDetailsViewController: UIViewController {
    
    @IBOutlet weak var numberOfItems: UILabel!
    @IBOutlet weak var viewCartButton: UIButton!
    @IBOutlet weak var totalAmount: UILabel!
    
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var moreDetailTableView: UITableView!
    
    let viewModel = DetailsViewModel()
    var passRestaurantName = ""
    var passRestaurantDiscount = ""
    
    var titleArray: [String] = []
    var amountArray: [Float] = []
    var imageArray: [UIImage] = []
    var quantityOfItems: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moreDetailTableView.register(DetailsTableViewCell.nib(),
                                     forCellReuseIdentifier: DetailsTableViewCell.identifier)
        title = "Menu"
        cartView.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        DispatchQueue.main.async {
            print(self.viewModel.mealList)
            self.moreDetailTableView.reloadData()
        }
        viewModel.completed = {
            print(self.viewModel.mealList)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("More details rest name: \(passRestaurantName) || and \(passRestaurantDiscount)")
    }

    @IBAction func viewCartButton(_ sender: UIButton) {
        let newStoryboard = UIStoryboard(name: "cart", bundle: nil)
        let newController = newStoryboard
            .instantiateViewController(identifier: "CartsViewController") as CartsViewController
        newController.viewModel.cartTitles = titleArray
        newController.viewModel.cartPrice = amountArray
        newController.viewModel.cartImage = imageArray
        newController.viewModel.cartNumber = quantityOfItems
        newController.restName = self.passRestaurantName
        newController.restDiscountValue = self.passRestaurantDiscount
        newController.title = "Cart"
        navigationController?.pushViewController(newController, animated: true)
        newController.modalTransitionStyle = .crossDissolve
        newController.modalPresentationStyle = .fullScreen
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? CartsViewController {
            controller.viewModel.cartTitles = titleArray
            controller.viewModel.cartPrice = amountArray
            controller.viewModel.cartImage = imageArray
            controller.viewModel.cartNumber = quantityOfItems
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "CartsViewController" {
            if titleArray.count < 1 {
                return false
            }
        }
        return true
    }

}

extension MoreDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mealList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = moreDetailTableView.dequeueReusableCell(withIdentifier:
                                                                        DetailsTableViewCell.identifier, for: indexPath)
                    as? DetailsTableViewCell else {fatalError()}
            
        cell.setup(with: viewModel.mealList[indexPath.row])
        cell.delegate = self
            return cell
    }
}

extension MoreDetailsViewController: MenuTableViewCellDelegate {
    func seeMore(with title: String) {
        
    }
}

extension MoreDetailsViewController: DetailsTableViewCellDelegate {
    
    func didTapAddBtn(with title: String, and amount: String, and titleImage: UIImage, and foodQuantiy: String) {
        cartView.isHidden = false
        self.titleArray.append(title)
        self.amountArray.append(Float("\(amount.suffix(amount.count - 1))") ?? 0)
        self.imageArray.append(titleImage)
        self.quantityOfItems.append(foodQuantiy)
        if titleArray.count == 1 {
            numberOfItems.text = String("\(titleArray.count) item")
        } else {
            numberOfItems.text = String("\(titleArray.count) items")
        }
        totalAmount.text = "$\(amountArray.reduce(0, +))"
        
    }
    
    func didTapRemoveBtn(with title: String, and amount: String, and titleImage: UIImage, and foodQuantiy: String) {
        self.titleArray.remove(at: titleArray.firstIndex(of: title)!)
        self.amountArray.remove(at: amountArray.firstIndex(of: Float("\(amount.suffix(amount.count - 1))")!)!)
        self.imageArray.remove(at: imageArray.firstIndex(of: titleImage)!)
        self.quantityOfItems.remove(at: quantityOfItems.firstIndex(of: foodQuantiy)!)
        if titleArray.count == 0 {
            cartView.isHidden = true
        } else if titleArray.count == 1 {
            numberOfItems.text = String("\(titleArray.count) item")
        } else {
            numberOfItems.text = String("\(titleArray.count) items")
        }
        totalAmount.text = "$\(amountArray.reduce(0, +))"
    }
    
}
