//
//  ConverterViewController.swift
//  UnitConverter
//
//  Created by Vithushan Gnanaraj on 2021-03-03.
//

import UIKit

class ConverterViewController: UIViewController {
    
    
    @IBOutlet weak var weightView: UIView!
    @IBOutlet weak var temperatureView: UIView!
    @IBOutlet weak var volumeView: UIView!
    @IBOutlet weak var lengthView: UIView!
    @IBOutlet weak var speedView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        
        if(sender.selectedSegmentIndex == 0){
            weightView.alpha = 1
            temperatureView.alpha = 0
            volumeView.alpha = 0
            lengthView.alpha = 0
            speedView.alpha = 0
        }
        else if(sender.selectedSegmentIndex == 1){
            weightView.alpha = 0
            temperatureView.alpha = 1
            volumeView.alpha = 0
            lengthView.alpha = 0
            speedView.alpha = 0
        }
        else if(sender.selectedSegmentIndex == 2){
            weightView.alpha = 0
            temperatureView.alpha = 0
            volumeView.alpha = 1
            lengthView.alpha = 0
            speedView.alpha = 0
        }
        else if(sender.selectedSegmentIndex == 3){
            weightView.alpha = 0
            temperatureView.alpha = 0
            volumeView.alpha = 0
            lengthView.alpha = 1
            speedView.alpha = 0
        }
        else if(sender.selectedSegmentIndex == 4){
            weightView.alpha = 0
            temperatureView.alpha = 0
            volumeView.alpha = 0
            lengthView.alpha = 0
            speedView.alpha = 1
        }
    }
    
}
