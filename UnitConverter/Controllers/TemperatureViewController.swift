//
//  TemperatureViewController.swift
//  UnitConverter
//
//  Created by Vithushan Gnanaraj on 2021-03-03.
//

import UIKit

enum TemperatureUnits: Int {
    case celsius, farenhite, kelvin
}

class TemperatureViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var celsiusTextField: UITextField!
    @IBOutlet weak var FahrenheitTextField: UITextField!
    @IBOutlet weak var kelvinTextField: UITextField!
    
    @IBOutlet weak var customKeyboardView: CustomKeyboardViewController!
    
    let defaults = UserDefaults.standard
    
    
    var temperature: Temperature = Temperature(celsius: 0.0, farenheit: 0.0, kelvin: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignDelegates()
        defaults.set(100, forKey: "precisionPoint")
    }
    
    func assignDelegates() {
        celsiusTextField.delegate = self
        FahrenheitTextField.delegate = self
        kelvinTextField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        customKeyboardView.activeTextField = textField
    }
    
    
    @IBAction func handleTextFieldChange(_ sender: UITextField) {
        
        
        guard let textFieldValue = sender.text else { return }
        if(textFieldValue != ""){
        guard let doubleTextFieldValue = Double(textFieldValue) else {return}
        
        let x: Double = defaults.double(forKey: "precisionPoint")

        switch TemperatureUnits(rawValue: sender.tag)! {
        
        case .celsius:
            temperature.celsius = doubleTextFieldValue
            temperature.farenheit = Double(round((doubleTextFieldValue * 9/5 + 32) * x )/x)
            temperature.kelvin = Double(round(doubleTextFieldValue + 273.15*x)/x)

            FahrenheitTextField.text = "\(temperature.farenheit)"
            kelvinTextField.text = "\(temperature.kelvin)"

        case .farenhite:
            temperature.celsius = Double(round((doubleTextFieldValue - 32) * 5/9*x)/x)
            temperature.farenheit = doubleTextFieldValue
            temperature.kelvin = Double(round((doubleTextFieldValue - 32) * 5/9 + 273.15*x)/x)

            celsiusTextField.text = "\(temperature.celsius)"
            kelvinTextField.text = "\(temperature.kelvin)"

        case .kelvin:
            temperature.celsius = Double(round(doubleTextFieldValue - 273.15*x)/x)
            temperature.farenheit = Double(round((doubleTextFieldValue - 273.15) * 9/5 + 32*x)/x)
            temperature.kelvin = doubleTextFieldValue

            celsiusTextField.text = "\(temperature.celsius)"
            FahrenheitTextField.text = "\(temperature.farenheit)"
        }
        }
        else{
            celsiusTextField.text = ""
            FahrenheitTextField.text = ""
            kelvinTextField.text = ""
        }
        
    }
  
    
    @IBAction func saveValue(_ sender: UIButton) {
        
        if (celsiusTextField.text != "" && FahrenheitTextField.text != "" && kelvinTextField.text != "" ){
        
        let defaults = UserDefaults.standard
        
        let historyString = "Celsius - \(temperature.celsius)\n  Fahrenheit - \(temperature.farenheit)\n Kelvin- \(temperature.kelvin)"
        
        (temperature.celsius, temperature.farenheit, temperature.kelvin) = (0,0,0)
            

            if(defaults.object(forKey: "temperatureHistory") != nil){
                temperature.historyArray = defaults.object(forKey: "temperatureHistory")! as? [String]
            }
//
//
        if(temperature.historyArray.count > 4){
            temperature.historyArray.removeFirst()
            temperature.historyArray.append(historyString)
            defaults.set(temperature.historyArray, forKey: "temperatureHistory")
            let alert = UIAlertController(title: "Great!", message: "successfully saved", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)
            celsiusTextField.text = ""
            FahrenheitTextField.text = ""
            kelvinTextField.text = ""
          
        }else{
            temperature.historyArray.append(historyString)
            defaults.set(temperature.historyArray, forKey: "temperatureHistory")
            let alert = UIAlertController(title: "Great!", message: "successfully saved", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)
            celsiusTextField.text = ""
            FahrenheitTextField.text = ""
            kelvinTextField.text = ""
        }
            
        }else{
            let alert = UIAlertController(title: "oops!", message: "fill the textfields before you save", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
    }
    

    @IBAction func clearValues(_ sender: UIButton) {
        celsiusTextField.text = ""
        FahrenheitTextField.text = ""
        kelvinTextField.text = ""
    }
    
}
