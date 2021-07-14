//
//  DetailsViewController.swift
//  Foodly
//
//  Created by mac on 09/06/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    let detailViewModel = DetailsViewModel()
    
    @IBOutlet weak var numberOfItems: UILabel!
    @IBOutlet weak var viewCartButton: UIButton!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailViewModel.getRestaurantMeals()
        tableView.register(DetailsTableViewCell.nib(), forCellReuseIdentifier: DetailsTableViewCell.identifier)
        tableView.register(ImageTableViewCell.nib(), forCellReuseIdentifier: ImageTableViewCell.identifier)
        tableView.register(MenuTableViewCell.nib(), forCellReuseIdentifier: MenuTableViewCell.identifier)
        cartView.isHidden = true
        title = detailViewModel.restaurantDetail[0].title
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        print("You have logged in with \(detailViewModel.restID)")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func viewCartButton(_ sender: UIButton) {
        let newStoryboard = UIStoryboard(name: "cart", bundle: nil)
        let newController = newStoryboard
            .instantiateViewController(identifier: "CartsViewController") as CartsViewController
        newController.viewModel.cartTitles = detailViewModel.titleArray
        newController.viewModel.cartPrice = detailViewModel.amountArray
        newController.viewModel.cartImage = detailViewModel.imageArray
        newController.viewModel.cartNumber = detailViewModel.quantityOfItems
        newController.restName = self.detailViewModel.passRestaurantName
        newController.restDiscountValue = self.detailViewModel.passRestaurantDiscount
        
        newController.title = "Cart"
        navigationController?.pushViewController(newController, animated: true)
        newController.modalTransitionStyle = .crossDissolve
        newController.modalPresentationStyle = .fullScreen
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? CartsViewController {
            controller.viewModel.cartTitles = detailViewModel.titleArray
            controller.viewModel.cartPrice = detailViewModel.amountArray
            controller.viewModel.cartImage = detailViewModel.imageArray
            controller.viewModel.cartNumber = detailViewModel.quantityOfItems
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "CartsViewController" {
            if detailViewModel.titleArray.count < 1 {
                return false
            }
        }
        return true
    }
    
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return detailViewModel.mealList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier) as? ImageTableViewCell else {return UIView()}
        self.tableView.tableHeaderView = cell
        cell.delegate = self
        if let unwrappedDetail = detailViewModel.restaurantDetailsList {
            cell.setUp(with: unwrappedDetail)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  DetailsTableViewCell.identifier, for: indexPath) as? DetailsTableViewCell else {
            return UITableViewCell()
        }
                    cell.setup(with: detailViewModel.mealList[indexPath.row])
                    cell.delegate = self
                    return cell
    }
    
}

extension DetailsViewController: DetailsTableViewCellDelegate {
    func didTapAddBtn(with title: String, and amount: String, and titleImage: UIImage, and foodQuantiy: String) {
        cartView.isHidden = false
        self.detailViewModel.titleArray.append(title)                               // - 1
        self.detailViewModel.amountArray.append(Float("\(amount.suffix(amount.count))") ?? 0)
        self.detailViewModel.imageArray.append(titleImage)
        self.detailViewModel.quantityOfItems.append(foodQuantiy)
        if detailViewModel.titleArray.count == 1 {
            numberOfItems.text = String("\(detailViewModel.titleArray.count) item")
        } else {
            numberOfItems.text = String("\(detailViewModel.titleArray.count) items")
        }
        totalAmount.text = "$\(detailViewModel.amountArray.reduce(0, +))"

    }
    
    func didTapRemoveBtn(with title: String, and amount: String, and titleImage: UIImage, and foodQuantiy: String) {
        self.detailViewModel.titleArray.remove(at: detailViewModel.titleArray.firstIndex(of: title)!)                              // - 1
        self.detailViewModel.amountArray.remove(at: detailViewModel.amountArray.firstIndex(of: Float("\(amount.suffix(amount.count))")!)!)
        self.detailViewModel.imageArray.remove(at: detailViewModel.imageArray.firstIndex(of: titleImage)!)
        self.detailViewModel.quantityOfItems.remove(at: detailViewModel.quantityOfItems.firstIndex(of: foodQuantiy)!)
        if detailViewModel.titleArray.count == 0 {
            cartView.isHidden = true
        } else if detailViewModel.titleArray.count == 1 {
            numberOfItems.text = String("\(detailViewModel.titleArray.count) item")
        } else {
            numberOfItems.text = String("\(detailViewModel.titleArray.count) items")
        }
        totalAmount.text = "$\(detailViewModel.amountArray.reduce(0, +))"
    }
}

extension DetailsViewController: ImageTableViewCellDelegate {
    func seeMore(with title: String) {
        let newStoryboard = UIStoryboard(name: "MoreDetails", bundle: nil)
        guard let newVC = newStoryboard
                .instantiateViewController(identifier: "MoreDetailsVC") as? MoreDetailsViewController else {
            return
        }
        newVC.passRestaurantName = self.detailViewModel.passRestaurantName
        newVC.passRestaurantDiscount = self.detailViewModel.passRestaurantDiscount
        navigationController?.pushViewController(newVC, animated: true)
        
    }
    
}


