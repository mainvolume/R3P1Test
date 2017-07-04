//
//  ViewController.swift
//  R3P1Test
//
//  Created by Ø on 04/07/2017.
//  Copyright © 2017 mainvolume. All rights reserved.
//

import UIKit



class MainController: UIViewController {
    
    
    @IBOutlet var stepCounters: [UIStepper]!
    
    @IBOutlet var itemLbls: [UILabel]!
    
    var currency:CurrencyList = .USD
    
    var indexer:CurrencyIndex!
    
    var checkOutTotal:Double = 0.0
    
    @IBOutlet weak var totalLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for v in self.view.subviews {
            v.alpha = 0.0
        }
        
        self.view.alpha = 1.0
        self.totalLbl.text = "loading data"
        actiivate()
               
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func countChanged(_ sender: Any) {
        loadData()
    }
    
    @IBAction func currencyChange(_ sender: UISegmentedControl) {
        updateCurrency(sender.selectedSegmentIndex)
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

