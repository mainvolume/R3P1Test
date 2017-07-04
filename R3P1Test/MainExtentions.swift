//
//  MainExtentions.swift
//  R3P1Test
//
//  Created by Ø on 04/07/2017.
//  Copyright © 2017 mainvolume. All rights reserved.
//

import UIKit


extension MainController {
    
    
    func loadData () {
        
        DispatchQueue.main.async {
            [weak self] succes in
            guard let `self` = self else { return }
            
            self.checkOutTotal = 0.0
            let symbol = self.currency.symbol
            
            for l in self.itemLbls {
                if let item = ShoppingItems(rawValue: UInt32(l.tag)) {
                    
                    var plural = ""
                    if Int(self.stepCounters[l.tag].value) > 1 || Int(self.stepCounters[l.tag].value) == 0 {
                        plural = "s"
                    }
                    
                    let price = item.price * self.indexer.getCurrentRation(current: self.currency)
                    let priceStr = String(format: "%.2f", price)
                    
                    let total = Double(price) * Double(self.stepCounters[l.tag].value)
                    self.checkOutTotal += total
                    let totalStr = String(format: "%.2f", total)
                    
                    l.text = "\(Int(self.stepCounters[l.tag].value)) \(item.unityType)\(plural) of \(item.name) à \(symbol) \(priceStr) = \(symbol) \(totalStr)"
                }
            }
            
            let checkOuttotalStr = String(format: "%.2f", self.checkOutTotal)
            
            self.totalLbl.text = "Your checkout total is : \(symbol) \(checkOuttotalStr)"
        }
    }
    
    func updateCurrency(_ idx:Int) {
        
        currency = CurrencyList(rawValue: UInt32(idx))!
        loadData()
        
    }
    
    
    func loadAPI(cb:@escaping (Bool)->()) {
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let request = URLRequest(url: NSURL(string: "http://apilayer.net/api/live?access_key=613556b5e111f6974e474bf62cfec90e&source=USD&currencies=EUR,GBP&format=1")! as URL)
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) -> Void in
            
            
            do {
                let response = try JSONSerialization.jsonObject(with: data!) as! [String:AnyObject]
                let GBPRatio = response["quotes"]?["USDGBP"] as! Double
                let EURRatio = response["quotes"]?["USDEUR"] as! Double
                self.indexer = CurrencyIndex(GBP: GBPRatio, EUR: EURRatio)
                print("Currency index retreived")
                if let _ = self.indexer {
                    cb(true)
                } else {
                    cb(false)
                }
            } catch {
                cb(false)
            }
            
        }
        task.resume()
        
    }
    
    func actiivate () {
        
        self.totalLbl.alpha = 1.0
        
        loadAPI { [weak self] succes in
            guard let `self` = self else { return }
            if succes {
                UIView.animate(withDuration: 0.33, animations: {
                    for v in self.view.subviews {
                        v.alpha = 1.0
                    }
                }, completion: { done in
                    self.loadData()
                })
                
            } else {
                print("Something went wrong")
            }
        }
    }
}
