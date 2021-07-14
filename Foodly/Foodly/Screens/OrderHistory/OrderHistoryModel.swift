//
//  OrderHistoryModel.swift
//  Foodly
//
//  Created by Decagon on 24.6.21.
//

import UIKit

class OrderHistoryModel {
    let orderHistory = OrderService()
    var orders = [HistoryDetail]()
    
    init() {
        orderHistory.getOrderHistory { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let userOrderHistory):
                var histories = [HistoryDetail]()
                userOrderHistory?.documents.forEach({ (history) in
                    let orderHistoryData = history.data()
                    if let cost = orderHistoryData["cost"] as? String,
                       let item = orderHistoryData["items"] as? String,
                       let name = orderHistoryData["name"]as? String,
                       let imageName = orderHistoryData["imageName"] as? String {
                        DispatchQueue.main.async {
                            let userHistory = HistoryDetail(name: name, itemNumber: item,
                                                            image: UIImage(named: imageName), amount: cost)
                            histories.append(userHistory)
                            self.orders = histories
                        }
                    }
                })
            }
        }
    }
}
