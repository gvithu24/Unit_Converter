//
//  VolumeViewController.swift
//  UnitConverter
//
//  Created by Vithushan Gnanaraj on 2021-03-03.
//

import UIKit

enum VolumeUnits: Int {
    case ukGallon, litre, ukPint, fluidOunce, millilitre
}

class VolumeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var ukGallonTextField: UITextField!
    @IBOutlet weak var litreTextField: UITextField!
    @IBOutlet weak var ukPintTextField: UITextField!
    @IBOutlet weak var fluidOunceTextField: UITextField!
    @IBOutlet weak var millilitreTextField: UITextField!
    
    @IBOutlet weak var customKeyboardView: CustomKeyboardViewController!
    
    let defaults = UserDefaults.standard
    
    var volume: Volume = Volume(ukGallon: 0.0, litre: 0.0, ukPint: 0.0, fluidOunce: 0.0, millilitre: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegates()
        customKeyboardView.neagtiveButton.isEnabled = false
        defaults.set(100, forKey: "precisionPoint")
        
        // Do any additional setup after loading the view.
    }
    
    func assignDelegates() {
        ukGallonTextField.delegate = self
        litreTextField.delegate = self
        ukPintTextField.delegate = self
        fluidOunceTextField.delegate = self
        millilitreTextField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        customKeyboardView.activeTextField = textField
    }
    
    
    @IBAction func handleTextFieldChange(_ sender: UITextField) {
        
        
        
        guard let textFieldValue = sender.text else { return }
        if(textFieldValue != ""){
        guard let doubleTextFieldValue = Double(textFieldValue) else {return}
        
        let x: Double = defaults.double(forKey: "precisionPoint")
        
        switch VolumeUnits(rawValue: sender.tag)! {
        
        case .ukGallon:
            volume.ukGallon = doubleTextFieldValue
            volume.litre = Double(round((doubleTextFieldValue * 4.546 )*x)/x)
            volume.ukPint = Double(round((doubleTextFieldValue * 8)*x)/x)
            volume.fluidOunce = Double(round((doubleTextFieldValue * 154)*x)/x)
            volume.millilitre = Double(round(doubleTextFieldValue * 4546 * x)/x)


            litreTextField.text = "\(volume.litre)"
            ukPintTextField.text = "\(volume.ukPint)"
            fluidOunceTextField.text = "\(volume.fluidOunce)"
            millilitreTextField.text = "\(volume.millilitre)"
        
            
            
        case .litre:
            volume.ukGallon = Double(round((doubleTextFieldValue / 4.546)*x)/x)
            volume.litre = doubleTextFieldValue
            volume.ukPint = Double(round(doubleTextFieldValue * 1.76*x)/x)
            volume.fluidOunce = Double(round(doubleTextFieldValue * 33.814*x)/x)
            volume.millilitre = Double(round(doubleTextFieldValue * 1000*x)/x)

            ukGallonTextField.text = "\(volume.ukGallon)"
            ukPintTextField.text = "\(volume.ukPint)"
            fluidOunceTextField.text = "\(volume.fluidOunce)"
            millilitreTextField.text = "\(volume.millilitre)"
            
        
            
        case .ukPint:
            volume.ukGallon = Double(round((doubleTextFieldValue / 8)*x)/x)
            volume.litre = Double(round((doubleTextFieldValue / 1.76)*x)/x)
            volume.ukPint = doubleTextFieldValue
            volume.fluidOunce = Double(round(doubleTextFieldValue * 19.215*x)/x)
            volume.millilitre = Double(round(doubleTextFieldValue * 568*x)/x)

            ukGallonTextField.text = "\(volume.ukGallon)"
            litreTextField.text = "\(volume.litre)"
            fluidOunceTextField.text = "\(volume.fluidOunce)"
            millilitreTextField.text = "\(volume.millilitre)"
            
            
        case .fluidOunce:
            volume.ukGallon = Double(round((doubleTextFieldValue / 154)*x)/x)
            volume.litre = Double(round((doubleTextFieldValue / 33.814)*x)/x)
            volume.ukPint = Double(round((doubleTextFieldValue / 19.215)*x)/x)
            volume.fluidOunce = doubleTextFieldValue
            volume.millilitre = Double(round((doubleTextFieldValue * 29.574)*x)/x)

            ukGallonTextField.text = "\(volume.ukGallon)"
            litreTextField.text = "\(volume.litre)"
            ukPintTextField.text = "\(volume.ukPint)"
            millilitreTextField.text = "\(volume.millilitre)"
            
        case .millilitre:
            volume.ukGallon = Double(round((doubleTextFieldValue / 4546)*x)/x)
            volume.litre = Double(round((doubleTextFieldValue / 1000)*x)/x)
            volume.ukPint =  Double(round((doubleTextFieldValue / 568)*x)/x)
            volume.fluidOunce = Double(round((doubleTextFieldValue/29.574)*x)/x)
            volume.millilitre = doubleTextFieldValue

            ukGallonTextField.text = "\(volume.ukGallon)"
            litreTextField.text = "\(volume.ukPint)"
            ukPintTextField.text = "\(volume.ukPint)"
            fluidOunceTextField.text = "\(volume.fluidOunce)"
        
        }
        }
        else{
            ukGallonTextField.text = ""
            litreTextField.text = ""
            ukPintTextField.text = ""
            fluidOunceTextField.text = ""
            millilitreTextField.text = ""
        }
    }
    
    func clear(){
        ukGallonTextField.text = ""
        litreTextField.text = ""
        ukPintTextField.text = ""
        fluidOunceTextField.text = ""
        millilitreTextField.text = ""
    }
    
    @IBAction func saveValue(_ sender: UIButton) {
        
        if (ukGallonTextField.text != "" && litreTextField.text != "" && ukPintTextField.text != "" && fluidOunceTextField.text != "" && millilitreTextField.text != ""  ){
        
        let defaults = UserDefaults.standard
        
            let historyString = "UK gallon - \(volume.ukGallon)\n  litre - \(volume.litre)\n UK pint- \(volume.ukPint)\n fluid ounce- \(volume.fluidOunce)\n millitre- \(volume.millilitre)"
        
            (volume.ukGallon, volume.litre, volume.ukPint, volume.fluidOunce,volume.millilitre) = (0,0,0,0,0)
        
            if(defaults.object(forKey: "volumeHistory") != nil){
                volume.historyArray = defaults.object(forKey: "volumeHistory")! as? [String]
            }
            
            
        if(volume.historyArray.count > 4){
            volume.historyArray.removeFirst()
            volume.historyArray.append(historyString)
            defaults.set(volume.historyArray, forKey: "volumeHistory")
            let alert = UIAlertController(title: "Great!", message: "successfully saved", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)
            clear()
          
        }else{
            volume.historyArray.append(historyString)
            defaults.set(volume.historyArray, forKey: "volumeHistory")
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
        ukGallonTextField.text = ""
        litreTextField.text = ""
        ukPintTextField.text = ""
        fluidOunceTextField.text = ""
        millilitreTextField.text = ""
    }
    

}
