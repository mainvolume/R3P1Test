//
//  Items.swift
//  R3P1Test
//
//  Created by Ø on 04/07/2017.
//  Copyright © 2017 mainvolume. All rights reserved.
//

import Foundation

protocol Items {
    var name: String { get }
    var price: Double { get }
    var unityType: String { get }
}

enum ShoppingItems: UInt32, Items {
    
    case Peas
    case Eggs
    case Milk
    case Beans
    
    
    var name: String {
        
        switch self {
        case .Peas:
            return "Peas"
        case .Milk:
            return "Eggs"
        case .Eggs:
            return "Milk"
        case .Beans:
            return "Beans"
        }
        
    }
    
    var price: Double {
        
        switch self {
        case .Peas:
            return 0.95
        case .Milk:
            return 2.10
        case .Eggs:
            return 1.30
        case .Beans:
            return 0.73
        }
        
    }
    
    var unityType: String {
        
        switch self {
        case .Peas:
            return "Bag"
        case .Milk:
            return "Dozen"
        case .Eggs:
            return "Bottle"
        case .Beans:
            return "Can"
        }
        
    }
    
    
    
    
    private static let itemCount: ShoppingItems.RawValue = {
        // find the maximum enum value
        var maxValue: UInt32 = 0
        while let _ = ShoppingItems(rawValue: maxValue) {
            maxValue += 1
        }
        return maxValue
    }()
}


protocol Currencies {
    var symbol: String { get }
}

enum CurrencyList: UInt32, Currencies {
    
    case USD
    case EUR
    case GBP
    
    var symbol: String {
        
        switch self {
        case .USD:
            return "$"
        case .EUR:
            return "€"
        case .GBP:
            return "£"
        }
        
    }
    
}


class CurrencyIndex {
    
    var USD:Double!
    var GBP:Double!
    var EUR:Double!
    
    init(USD:Double = 1.0, GBP:Double, EUR:Double) {
        self.USD = USD
        self.GBP = GBP
        self.EUR = EUR
    }
    
    func getCurrentRation(current:CurrencyList) -> Double {
        switch current {
        case .USD:
            return self.USD
        case .EUR:
            return self.EUR
        case .GBP:
            return self.GBP
        }
        
    }
    
}
