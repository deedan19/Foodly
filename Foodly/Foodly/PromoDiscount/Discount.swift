//
//  Discount.swift
//  Foodly
//
//  Created by Decagon on 26/06/2021.
//

import Foundation
import FirebaseRemoteConfig

class Discount {
    let remoteConfig = RemoteConfig.remoteConfig()
    var promoValues: String?
    
    func getDiscount () {
        fetchPromoCodesFromConfig()
        
    }
    
    func setDefaultPromoCode () {
        let defaults: [String: NSObject] = ["testing": "enjoy yourself" as NSObject]
        remoteConfig.setDefaults(defaults)
        let settings = RemoteConfigSettings()
            settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        let cachedValue = self.remoteConfig.configValue(forKey: "testing").stringValue
        cachedConfig(value: cachedValue ?? "")
    }
    
    func getValue (getValue: String?) -> String {
        var value = ""
        print("Value gotten from that yeye place: \(String(describing: getValue))")
        if let newValue = getValue {
            value = newValue
        }
        return value
    }
    
    func fetchPromoCodesFromConfig () {
        setDefaultPromoCode()
        
        self.remoteConfig.fetch(completionHandler: { status, error in
            if status == .success, error == nil {
                self.remoteConfig.activate(completion: {  success, error in
                    guard error == nil else { return }
                    guard  let value = self.remoteConfig.configValue(forKey: "testing").stringValue else { return }
                    DispatchQueue.main.async {
                        self.promoValues = value
                        self.getValue(getValue: value)
                        print("pRomo code: \(self.promoValues)")
                    }
                })
            } else {
                print("Something went wrong")
            }
        })
//        print("pRomo code: \(promoValues)")
    }
    
    func cachedConfig (value: String) {
        print("This is the value: \(value)")
    }
    
}
