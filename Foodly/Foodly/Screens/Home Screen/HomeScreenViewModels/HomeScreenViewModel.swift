//
//  HomeScreenViewModel.swift
//  Foodly
//
//  Created by Decagon on 24/06/2021.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class HomeScreenViewModel {
    
    init() {
        welcomeText = gettime()
    }
    
    let categoryService = CategoryService()
    
    var categoriesCompletion : (() -> Void)?
    
    var categoriesArray = [DishCategory]()
    

    func fetchCategories() {
        
        categoryService.getCategory() { (output) in
            switch output {
            case.failure(let error):
                print(error)
            case .success(let queryDocument):
                var dishCategoriesArray = [DishCategory]()
                queryDocument?.documents.forEach({ result in
                    let resultData = result.data()
                    if let categories = resultData["name"] as? String, let image = resultData["image"] {
                        let dishCategory = DishCategory(name: categories, image: UIImage(named: "\(image)") ?? #imageLiteral(resourceName: "miang"))
                        dishCategoriesArray.append(dishCategory)
                    }
                })
                self.categoriesArray = dishCategoriesArray
                self.categoriesCompletion?()
            }
        }
    }

    
    var restaurantCategories = [Restaurants]()
    
    var closureForFirstNameDisplay:(() -> Void)?
    var welcomeTextCompletion:(() -> Void)?
    var firstWordAppend = " "
    
    func gettime() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 1..<12 :
            return(NSLocalizedString("Good Morning", comment: "Morning"))
        case 12..<17 :
            return (NSLocalizedString("Good Afternoon", comment: "Afternoon"))
        default:
            return (NSLocalizedString("Good Evening", comment: "Evening"))
        }
        
    }
    
    var restaurantList = [Restaurants]()
    let restaurantsService = RestaurantService()
    var restaurantIDS = [String]()
    
    var closure:(() -> Void)? // created closure
    
    func fetchRestaurants(categoryName: String? = nil) {
        
        restaurantsService.getRestaurants(categoryName: categoryName) { (output) in
            switch output {
            case .failure(let error):
                print(error)
            case .success(let queryDocument):
                var restaurantsFilteredArray = [Restaurants]()
                queryDocument?.documents.forEach({ (result) in
                    let resultData = result.data()
                    if let restaurantName = resultData["name"] as? String,
                       let imageName = resultData["imageName"] as? String,
                       let discount = resultData["discount"] as? String,
                       let mealType = resultData["mealType"] as? String,
                       let time = resultData["time"] as? String,
                       let restID = result.documentID as? String{
                        let eachRestaurant = Restaurants(restaurantName: restaurantName,
                                                         restaurantImage: UIImage(imageLiteralResourceName: imageName),
                                                         category: mealType,
                                                         timeLabel: time, discountLabel: discount)
                        
                        self.restaurantIDS.append(restID)
                        restaurantsFilteredArray.append(eachRestaurant)
                    }
                    
                })
                self.restaurantList = restaurantsFilteredArray
                self.closure?()// optionally call closure
            }
        }
    }
    
    var welcomeText = ""
    
    func getUserName() {
        let docId = Auth.auth().currentUser?.uid
        let docRef = Firestore.firestore().collection("users").document(docId!)
        docRef.getDocument {(document, error) in
            if let document = document, document.exists {
                let docData = document.data()
                let status = docData!["fullName"] as? String ?? ""
                let firstWord = status.components(separatedBy: " ").first
                self.welcomeText = "\(self.gettime()), \(firstWord!)"
                self.welcomeTextCompletion?()
            } else {
                print(error as Any)
            }
        }
    }
}
