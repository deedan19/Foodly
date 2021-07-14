//
//  DeliveryPersonViewModel.swift
//  Foodly
//
//  Created by Decagon on 23.6.21.
//

import UIKit

class DeliveryViewModel {
    
    var name = ""
    var time = ""
    var imageName = ""
    var phone = ""
    
    let deliveryService = DeliveryService()
    var confirmationDetailsCompletion: (() -> Void)?
    
    init() {
        
        deliveryService.getDeliveryPeson { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let deliveryPersons):
                deliveryPersons?.documents.forEach({ (person) in
                    let deliveryData = person.data()
                    guard let deliveryName = deliveryData["name"],
                          let deliveryTime = deliveryData["deliveryTime"],
                          let imgName = deliveryData["imageName"],
                          let phoneNumber = deliveryData["phoneNumber"] else {return}
                    
                    if let name = deliveryName as? String {
                        self.name = name
                    }
                    if let time = deliveryTime as? String {
                        self.time = time
                    }
                    if let imageName = imgName as? String {
                        self.imageName = imageName
                    }
                    if let phone = phoneNumber as? String {
                        self.phone = phone
                    }
                })
                self.confirmationDetailsCompletion?()
            }
        }
    }
}
