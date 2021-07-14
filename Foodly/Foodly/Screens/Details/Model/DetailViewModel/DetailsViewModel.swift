//
//  ViewModel.swift
//  Foodly
//
//  Created by mac on 10/06/2021.
//

import UIKit
import Firebase

class DetailsViewModel {
    
    var restaurantData: DetailModel?
    
    let mealService = MealService()
    var restaurantList = [Restaurants]()
    var mealList = [MealsModel]()
    var passRestaurantName = ""
    var passRestaurantDiscount = ""
    var restaurantDetailsList: Restaurants?

    var titleArray: [String] = []
    var amountArray: [Float] = []
    var imageArray: [UIImage] = []
    var quantityOfItems: [String] = []
    var restID: String = ""
    var completed: (() -> Void)?
    var restaurantDetail: [DetailModel] = [
        
        DetailModel(title: "Conrad food", type: "Pizza • Fastfood", image: "ConradFood", amount: nil),
        DetailModel(title: "Veg Loaded", type: "In Veg Pizza", image: "VegLoaded", amount: "$12.50"),
        DetailModel(title: "Veg Loaded", type: "In Pizza Mania", image: "VegLoaded", amount: "$8.50"),
        DetailModel(title: "Farm House", type: "In Pizza Mania", image: "FarmHouse", amount: "$8.50"),
        DetailModel(title: "Fresh Veggie", type: "In Pizza Mania", image: "FreshVeggie", amount: "$11.99"),
        DetailModel(title: "Veg Loaded", type: "In Pizza Mania", image: "VegLoaded", amount: "$8.50")
    ]
    
    func getRestaurantMeals() {
        print("Confirming the id1: \(self.restID)")
            mealService.getMeals(restaurantId: restID) {(result) in
                print("Confirming the id: \(self.restID)")
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let querySnapshot):
                    querySnapshot?.documents.forEach({ (result) in
                        let data = result.data()
                        if let mealName = data["name"] as? String,
                           let mealImageName = data["imageName"] as? String,
                           let mealRecipe = data["recipe"] as? String,
                           let mealPrice = data["price"] as? String {
                            guard let newPrice = Double(mealPrice) else { return }
                            let mealNewPrice = String(newPrice / 100.0)
                            let eachMeal = MealsModel(mealName: mealName,
                            mealImage: UIImage(imageLiteralResourceName: mealImageName),
                            mealPrice: mealNewPrice, mealRecipe: mealRecipe)
                            self.mealList.append(eachMeal)
                           
                        }
                        self.completed?()
                    })
                }
            }
        }
}
