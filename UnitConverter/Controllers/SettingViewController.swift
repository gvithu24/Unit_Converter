//
//  SettingViewController.swift
//  UnitConverter
//
//  Created by Vithushan Gnanaraj on 2021-03-14.
//

import UIKit

class SettingViewController: UIViewController {
    
    
    @IBOutlet var precisionLabel: UILabel!
    
    
    @IBAction func stepper(_ sender: UIStepper) {
        let defaults = UserDefaults.standard
        
        precisionLabel.text = String(sender.value)
        
        if(sender.value == 2){
            defaults.set(100, forKey: "precisionPoint")
        }else if(sender.value == 3){
            defaults.set(1000, forKey: "precisionPoint")
        }else if(sender.value == 4){
            defaults.set(10000, forKey: "precisionPoint")
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
