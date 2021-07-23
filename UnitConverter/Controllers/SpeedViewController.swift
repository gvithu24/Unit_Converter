//
//  SpeedViewController.swift
//  UnitConverter
//
//  Created by Vithushan Gnanaraj on 2021-03-03.
//

import UIKit

enum SpeedUnits: Int {
    case metreSec, kmHour, mileHour, nauticalMileHour
}

class SpeedViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var msTextField: UITextField!
    @IBOutlet weak var kmhTextField: UITextField!
    @IBOutlet weak var mhTextField: UITextField!
    @IBOutlet weak var nauticalMhTextField: UITextField!
    
    @IBOutlet weak var customKeyboardView: CustomKeyboardViewController!
    
    let defaults = UserDefaults.standard
    
    var speed: Speed = Speed(metreSec: 0.0, kmHour: 0.0, mileHour: 0.0, nauticalMileHour: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegates()
        customKeyboardView.neagtiveButton.isEnabled = false
        defaults.set(100, forKey: "precisionPoint")
        // Do any additional setup after loading the view.
    }

    func assignDelegates() {
        msTextField.delegate = self
        kmhTextField.delegate = self
        mhTextField.delegate = self
        nauticalMhTextField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        customKeyboardView.activeTextField = textField
    }
    
    
    @IBAction func handleTextFieldChange(_ sender: UITextField) {
        
        
        guard let textFieldValue = sender.text else { return }
        
        if(textFieldValue != ""){
        guard let doubleTextFieldValue = Double(textFieldValue) else {return}
        
        let x: Double = defaults.double(forKey: "precisionPoint")
        
        switch SpeedUnits(rawValue: sender.tag)! {
        
            
        case .metreSec:
            speed.metreSec = doubleTextFieldValue
            speed.kmHour = Double(round((doubleTextFieldValue * 18/5 )*x)/x)
            speed.mileHour = Double(round((doubleTextFieldValue * 2.237)*x)/x)
            speed.nauticalMileHour = Double(round((doubleTextFieldValue * 1.944)*x)/x)

            kmhTextField.text = "\(speed.kmHour)"
            mhTextField.text = "\(speed.mileHour)"
            nauticalMhTextField.text = "\(speed.nauticalMileHour)"
            
        
        case .kmHour:
            speed.metreSec = Double(round((doubleTextFieldValue * 5/18)*x)/x)
            speed.kmHour = doubleTextFieldValue
            speed.mileHour =  Double(round((doubleTextFieldValue / 1.609)*x)/x)
            speed.nauticalMileHour = Double(round((doubleTextFieldValue / 1.852)*x)/x)
            
            msTextField.text = "\(speed.metreSec)"
            mhTextField.text = "\(speed.mileHour)"
            nauticalMhTextField.text = "\(speed.nauticalMileHour)"
            
            
            
        case .mileHour:
            speed.metreSec = Double(round((doubleTextFieldValue / 2.237)*x)/x)
            speed.kmHour = Double(round(doubleTextFieldValue * 1.609*x)/x)
            speed.mileHour = doubleTextFieldValue
            speed.nauticalMileHour = Double(round((doubleTextFieldValue / 1.151)*x)/x)
            
            msTextField.text = "\(speed.metreSec)"
            kmhTextField.text = "\(speed.kmHour)"
            nauticalMhTextField.text = "\(speed.nauticalMileHour)"
            
        case .nauticalMileHour:
            speed.metreSec = Double(round((doubleTextFieldValue / 1.944)*x)/x)
            speed.kmHour = Double(round((doubleTextFieldValue * 1.852)*x)/x)
            speed.mileHour = Double(round((doubleTextFieldValue * 1.151)*x)/x)
            speed.nauticalMileHour = doubleTextFieldValue
            
            msTextField.text = "\(speed.metreSec)"
            kmhTextField.text = "\(speed.kmHour)"
            mhTextField.text = "\(speed.mileHour)"
            
        }
        }else{
            msTextField.text = ""
            kmhTextField.text = ""
            mhTextField.text = ""
            nauticalMhTextField.text = ""
        }
    }
    
    func clear(){
        msTextField.text = ""
        kmhTextField.text = ""
        mhTextField.text = ""
        nauticalMhTextField.text = ""
    }
    
    @IBAction func saveValues(_ sender: UIButton) {
        
        if (msTextField.text != "" && kmhTextField.text != "" && mhTextField.text != "" && nauticalMhTextField.text != "" ){
        
        let defaults = UserDefaults.standard
        
            let historyString = "m/s - \(speed.metreSec)\n  km/h - \(speed.kmHour)\n miles/h- \(speed.mileHour)\n nautical miles/h- \(speed.nauticalMileHour)"
        
            (speed.metreSec, speed.kmHour, speed.mileHour, speed.nauticalMileHour) = (0,0,0,0)
        
            
            if(defaults.object(forKey: "speedHistory") != nil){
                speed.historyArray = defaults.object(forKey: "speedHistory")! as? [String]
            }
            
        if(speed.historyArray.count > 4){
            speed.historyArray.removeFirst()
            speed.historyArray.append(historyString)
            defaults.set(speed.historyArray, forKey: "speedHistory")
            let alert = UIAlertController(title: "Great!", message: "successfully saved", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)
            clear()
          
        }else{
            speed.historyArray.append(historyString)
            defaults.set(speed.historyArray, forKey: "speedHistory")
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
        msTextField.text = ""
        kmhTextField.text = ""
        mhTextField.text = ""
        nauticalMhTextField.text = ""
    }
    
}
