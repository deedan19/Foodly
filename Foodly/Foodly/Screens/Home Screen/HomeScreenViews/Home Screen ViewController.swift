//
//  Home Screen ViewController.swift
//  Foodly
//
//  Created by Decagon on 05/06/2021.
//

import UIKit

class HomeScreenViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var homeScreenViewModel = HomeScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeScreenViewModel.fetchCategories()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        tableView.register(UINib(nibName: "RestaurantsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.tabBarController?.tabBar.isHidden = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        homeScreenViewModel.fetchRestaurants()
        homeScreenViewModel.getUserName()
        homeScreenViewModel.closure = { [weak self] in
            guard let self = self else {return}
            
            
            self.tableView.reloadData()
        }
        homeScreenViewModel.welcomeTextCompletion = { [weak self] in
            guard let self = self else {return}
            self.welcomeLabel.text = self.homeScreenViewModel.welcomeText
        }
        
        homeScreenViewModel.categoriesCompletion = { [weak self] in
            guard let strongself = self else {return}
            strongself.collectionView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        tableView.reloadData()
        
    }
    
}
extension HomeScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeScreenViewModel.categoriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell =
                collectionView.dequeueReusableCell(withReuseIdentifier: HomeScreenFoodCollectionViewCell.identifier,
                                                   for: indexPath)
                as? HomeScreenFoodCollectionViewCell else {return UICollectionViewCell()}
        cell.setup(category: homeScreenViewModel.categoriesArray[indexPath.row])
        return cell 
    }
    
}

extension HomeScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 55, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var mealName: String?
        
        mealName = indexPath.row == 0 ? nil : homeScreenViewModel.categoriesArray[indexPath.row].name
         
        homeScreenViewModel.fetchRestaurants(categoryName: mealName)
        
    }
    
}

extension HomeScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeScreenViewModel.restaurantList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let  cell = tableView.dequeueReusableCell(withIdentifier:
                                                            "cell", for: indexPath)
                as? RestaurantsTableViewCell else {return UITableViewCell()
            
        }
        
        cell.setup(with: homeScreenViewModel.restaurantList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = homeScreenViewModel.restaurantList[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewController = UIStoryboard(name: "Details", bundle: nil)
                .instantiateViewController(identifier: "DetailsVC")
                as? DetailsViewController else {return}
        viewController.detailViewModel.restaurantDetailsList = detail
        viewController.detailViewModel.passRestaurantName = detail.restaurantName
        viewController.detailViewModel.passRestaurantDiscount = detail.discountLabel
        viewController.detailViewModel.restID = homeScreenViewModel.restaurantIDS[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}
