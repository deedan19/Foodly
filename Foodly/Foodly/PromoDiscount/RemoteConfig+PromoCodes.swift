//
//  RemoteConfig+PromoCodes.swift
//  Foodly
//
//  Created by Decagon on 28/06/2021.
//

import Foundation
import FirebaseRemoteConfig

class RemoteConfigPromoCodes {
    var promoCodes = ""
    var taxValue = ""
    let remoteConfig = RemoteConfig.remoteConfig()
    
    
    
    fileprivate func setDefaults() {
        let defaults: [String: NSObject] = [
            "tax": "5" as NSObject
        ]
        remoteConfig.setDefaults(defaults)
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        let cachedTaxValue = self.remoteConfig.configValue(forKey: "tax").stringValue
        let cachedPromoValue = self.remoteConfig.configValue(forKey: "promoCode").stringValue

        updateUI(taxValue: cachedTaxValue, promoValue: cachedPromoValue)
    }
    
    func fetchValue() {
        setDefaults()
        
        self.remoteConfig.fetch(withExpirationDuration: 0) { status, error in
            if status == .success, error == nil {
                self.remoteConfig.activate(completion: {success, error in
                    guard error == nil else { return }
                    let taxValue = self.remoteConfig.configValue(forKey: "tax").stringValue
                    let promoValue = self.remoteConfig.configValue(forKey: "promoCode").stringValue
                    DispatchQueue.main.async {
                        self.taxValue = taxValue ?? "Could not get tax"
                        self.promoCodes = promoValue ?? "Could not get promo codes"
                    }
                })
            } else {
                print("Something went wrong")
            }
        }
    }
    
    private func updateUI (taxValue: String?, promoValue: String? ) {
    }
}
