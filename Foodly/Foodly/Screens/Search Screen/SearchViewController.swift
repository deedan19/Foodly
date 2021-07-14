//
//  SearchViewController.swift
//  Foodly
//
//  Created by Decagon on 15/06/2021.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var searchTextField: UITextField!

    var filteredData: [Restaurants]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Foods"
        table.register(UINib(nibName: "RestaurantsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        table.dataSource = self
        table.delegate = self
        searchBar.delegate = self
        filteredData = []
//        searchForRestaurants()

    }
    
   
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return restaurant.count
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let  cell = tableView.dequeueReusableCell(withIdentifier:
                                                            "cell", for: indexPath)
                as? RestaurantsTableViewCell else {return UITableViewCell()}
//        cell.setup(with: restaurant[indexPath.row])
        cell.setup(with: filteredData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = filteredData[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewController = UIStoryboard(name: "Details", bundle: nil)
                .instantiateViewController(identifier: "DetailsVC")
                as? DetailsViewController else {return}
        navigationController?.pushViewController(viewController, animated: true)
    }
//
//    private func searchForRestaurants () {
//        filteredData = []
//        if searchTextField.text == "" {
//            filteredData = []
//        } else {
//            for restaurantSearched in restaurant {
//                let restaurant = restaurantSearched.restaurantName.lowercased()
//                let restaurantFood = restaurantSearched.category.lowercased()
//                if restaurant.contains(searchTextField.text!.lowercased()) || restaurantFood.contains(searchTextField.text!.lowercased()) {
//                    filteredData.append(restaurantSearched)
//                }
//            }
//        }
//        table.reloadData()
//    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        if searchText == "" {
            filteredData = []
        } else {
            for restaurantSearched in restaurant {
                let restaurant = restaurantSearched.restaurantName.lowercased()
                let restaurantFood = restaurantSearched.category.lowercased()
                if restaurant.contains(searchText.lowercased()) || restaurantFood.contains(searchText.lowercased()) {
                    filteredData.append(restaurantSearched)
                }
            }
        }
        table.reloadData()
    }
    
}
