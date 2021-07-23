//
//  WeightViewController.swift
//  UnitConverter
//
//  Created by Vithushan Gnanaraj on 2021-03-03.
//

import UIKit

enum WeightUnits: Int {
    case ounce, pound, gram, stone, stonePound, kg
}

class WeightViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var ounceTextField: UITextField!
    @IBOutlet weak var poundTextField: UITextField!
    @IBOutlet weak var gramTextField: UITextField!
    @IBOutlet weak var stoneTextField: UITextField!
    @IBOutlet weak var stonePoundTextField: UITextField!
    @IBOutlet weak var kgTextField: UITextField!
    
   
    
    @IBOutlet var customKeyboardView:CustomKeyboardViewController!
    
    let defaults = UserDefaults.standard
    
    var weight: Weight = Weight(ounce: 0.0, pound: 0.0, gram: 0.0, stone: 0.0, stonePound: 0.0, kg: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegates()
        customKeyboardView.neagtiveButton.isEnabled = false
        stonePoundTextField.isUserInteractionEnabled = false
        defaults.set(100, forKey: "precisionPoint")
//        ounceTextField.inputView = UIView()
    }
    
    func assignDelegates() {
        ounceTextField.delegate = self
        poundTextField.delegate = self
        gramTextField.delegate = self
        stoneTextField.delegate = self
        stonePoundTextField.delegate = self
        kgTextField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        customKeyboardView.activeTextField = textField
    }
    
    
    @IBAction func handleTextFieldChange(_ sender: UITextField) {
        let x: Double = defaults.double(forKey: "precisionPoint")
        
        guard let textFieldValue = sender.text else { return }
        
        if(textFieldValue != ""){
        guard let doubleTextFieldValue = Double(textFieldValue) else {return}
                    
        switch WeightUnits(rawValue: sender.tag)! {

        case .ounce:
            weight.ounce = doubleTextFieldValue
            weight.pound = Double(round((doubleTextFieldValue / 16 )*x)/x)
            weight.gram = Double(round((doubleTextFieldValue * 28.35)*x)/x)
            weight.stone = ( (doubleTextFieldValue / 16) / 14 ).rounded(.towardZero)
            weight.stonePound = Double(round((( doubleTextFieldValue / 16 ) - (weight.stone * 14))*x)/x)
            weight.kg = Double(round((doubleTextFieldValue / 35.274)*x)/x)

            poundTextField.text = "\(weight.pound)"
            gramTextField.text = "\(weight.gram)"
            stoneTextField.text = "\(weight.stone)"
            stonePoundTextField.text = "\(weight.stonePound)"
            kgTextField.text = "\(weight.kg)"
            
        case .pound:
            weight.ounce = Double(round((doubleTextFieldValue * 16)*x)/x)
            weight.pound = doubleTextFieldValue
            weight.gram = Double(round((doubleTextFieldValue * 454)*x)/x)
            weight.stone = (( doubleTextFieldValue / 14 ).rounded(.towardZero))
            weight.stonePound = Double(round((( doubleTextFieldValue) - (weight.stone * 14))*x)/x)
            weight.kg = Double(round((doubleTextFieldValue / 2.205)*x)/x)
            
            ounceTextField.text = "\(weight.ounce)"
            gramTextField.text = "\(weight.gram)"
            stoneTextField.text = "\(weight.stone)"
            stonePoundTextField.text = "\(weight.stonePound)"
            kgTextField.text = "\(weight.kg)"
            

        case .gram:
            weight.ounce = Double(round((doubleTextFieldValue / 28.35)*x)/x)
            weight.pound = Double(round((doubleTextFieldValue / 454)*x)/x)
            weight.gram = doubleTextFieldValue
            weight.stone = ( (doubleTextFieldValue/454) / 14 ).rounded(.towardZero)
            weight.stonePound = Double(round(( ( doubleTextFieldValue/454) - (weight.stone * 14) )*x)/x)
            weight.kg = Double(round((doubleTextFieldValue / 1000)*x)/x)
            
            ounceTextField.text = "\(weight.ounce)"
            poundTextField.text = "\(weight.pound)"
            stoneTextField.text = "\(weight.stone)"
            stonePoundTextField.text = "\(weight.stonePound)"
            kgTextField.text = "\(weight.kg)"
            
            
        case .stone:
            weight.ounce = Double(round(((doubleTextFieldValue * 224) + (weight.stonePound * 16))*x)/x)
            weight.pound = Double(round(((doubleTextFieldValue * 14) + (weight.stonePound * 16))*x)/x)
            weight.gram = Double(round(((doubleTextFieldValue * 6350) + (weight.stonePound * 16))*x)/x)
            weight.stone = doubleTextFieldValue
            weight.kg = Double(round((doubleTextFieldValue * 6.35)*x)/x)
            
            ounceTextField.text = "\(weight.ounce)"
            poundTextField.text = "\(weight.pound)"
            gramTextField.text = "\(weight.gram)"
            kgTextField.text = "\(weight.kg)"

            
        case .stonePound:
            return

        case .kg:
            weight.ounce = Double(round((doubleTextFieldValue * 35.274)*x)/x)
            weight.pound = Double(round((doubleTextFieldValue * 2.205)*x)/x)
            weight.gram = Double(round((doubleTextFieldValue * 1000)*x)/x)
            weight.stone = ( (doubleTextFieldValue/6.35029318) ).rounded(.towardZero)
            weight.stonePound = (Double(round((doubleTextFieldValue * 2.205)*x)/x))-(( (doubleTextFieldValue/6.35029318) ).rounded(.towardZero)*14)
            weight.kg = doubleTextFieldValue

            ounceTextField.text = "\(weight.ounce)"
            poundTextField.text = "\(weight.pound)"
            gramTextField.text = "\(weight.gram)"
            stoneTextField.text = "\(weight.stone)"
            stonePoundTextField.text = "\(weight.stonePound)"
        }
            
        }
        else{
            ounceTextField.text = ""
            poundTextField.text = ""
            gramTextField.text = ""
            stoneTextField.text = ""
            stonePoundTextField.text = ""
            kgTextField.text = ""
        }
    }
    
    
    func clear(){
        ounceTextField.text = ""
        poundTextField.text = ""
        gramTextField.text = ""
        stoneTextField.text = ""
        stonePoundTextField.text = ""
        kgTextField.text = ""
    }
    
    @IBAction func saveValues(_ sender: UIButton) {
        
        if (ounceTextField.text != "" && poundTextField.text != "" && gramTextField.text != "" && stoneTextField.text != "" && stonePoundTextField.text != "" && kgTextField.text != ""  ){
        
            let historyString = "ounce - \(weight.ounce)\n  pound - \(weight.pound)\n gram- \(weight.gram)\n stone- \(weight.stone) pound- \(weight.stonePound) \n kg- \(weight.kg)"
        
            (weight.ounce, weight.pound, weight.gram,weight.stone,weight.stonePound,weight.kg) = (0,0,0,0,0,0)
            
            if(defaults.object(forKey: "weightHistory") != nil){
                weight.historyArray = defaults.object(forKey: "weightHistory")! as? [String]
            }
            
            
        if(weight.historyArray.count > 4){
            weight.historyArray.removeFirst()
            weight.historyArray.append(historyString)
            defaults.set(weight.historyArray, forKey: "weightHistory")
            let alert = UIAlertController(title: "Great!", message: "successfully saved", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)
            clear()
          
        }else{
            weight.historyArray.append(historyString)
            defaults.set(weight.historyArray, forKey: "weightHistory")
            let alert = UIAlertController(title: "Great!", message: "successfully saved", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)
            clear()
        }
            
        }else{
            let alert = UIAlertController(title: "oops!", message: "fill the textfields before you save", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
        
    }
    
    
    
    @IBAction func clearValues(_ sender: UIButton) {
        ounceTextField.text = ""
        poundTextField.text = ""
        gramTextField.text = ""
        stoneTextField.text = ""
        stonePoundTextField.text = ""
        kgTextField.text = ""
    }
    
}
