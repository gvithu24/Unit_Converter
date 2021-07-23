//
//  LengthViewController.swift
//  UnitConverter
//
//  Created by Vithushan Gnanaraj on 2021-03-03.
//

import UIKit

enum LengthUnits: Int {
    case metre, km, mile, cm, mm, yard, inch
}

class LengthViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var metreTextField: UITextField!
    @IBOutlet weak var kmTextField: UITextField!
    @IBOutlet weak var mileTextField: UITextField!
    @IBOutlet weak var cmTextField: UITextField!
    @IBOutlet weak var mmTextField: UITextField!
    @IBOutlet weak var yardTextField: UITextField!
    @IBOutlet weak var inchTextField: UITextField!

    @IBOutlet weak var customKeyboardView: CustomKeyboardViewController!
    
    let defaults = UserDefaults.standard
    
    var length: Length = Length(metre: 0.0, km: 0.0, mile: 0.0, cm: 0.0, mm: 0.0, yard: 0.0, inch: 0.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegates()
        customKeyboardView.neagtiveButton.isEnabled = false
        defaults.set(100, forKey: "precisionPoint")
        // Do any additional setup after loading the view.
    }
    
    func assignDelegates() {
        metreTextField.delegate = self
        kmTextField.delegate = self
        mileTextField.delegate = self
        cmTextField.delegate = self
        mmTextField.delegate = self
        yardTextField.delegate = self
        inchTextField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        customKeyboardView.activeTextField = textField
    }
    
    @IBAction func handleTextFieldChange(_ sender: UITextField) {
        

        
        guard let textFieldValue = sender.text else { return }
        if(textFieldValue != ""){
        guard let doubleTextFieldValue = Double(textFieldValue) else {return}
        
        let x: Double = defaults.double(forKey: "precisionPoint")
    
        
        switch LengthUnits(rawValue: sender.tag)! {
        case .metre:
            length.metre = doubleTextFieldValue
            length.km = Double(round((doubleTextFieldValue / 1000 )*x)/x)
            length.mile = Double(round((doubleTextFieldValue / 1609)*x)/x)
            length.cm = Double(round((doubleTextFieldValue * 100)*x)/x)
            length.mm = Double(round((doubleTextFieldValue * 1000)*x)/x)
            length.yard = Double(round((doubleTextFieldValue * 1.094)*x)/x)
            length.inch = Double(round((doubleTextFieldValue * 39.37)*x)/x)

            kmTextField.text = "\(length.km)"
            mileTextField.text = "\(length.mile)"
            cmTextField.text = "\(length.cm)"
            mmTextField.text = "\(length.mm)"
            yardTextField.text = "\(length.yard)"
            inchTextField.text = "\(length.inch)"
            
                
        case .km:
            length.metre = Double(round((doubleTextFieldValue * 1000)*x)/x)
            length.km = doubleTextFieldValue
            length.mile = Double(round((doubleTextFieldValue / 1.609)*x)/x)
            length.cm = Double(round((doubleTextFieldValue * 100000)*x)/x)
            length.mm = Double(round((doubleTextFieldValue * 1000000)*x)/x)
            length.yard =  Double(round((doubleTextFieldValue * 1094)*x)/x)
            length.inch = Double(round((doubleTextFieldValue * 39370)*x)/x)

            metreTextField.text = "\(length.metre)"
            mileTextField.text = "\(length.mile)"
            cmTextField.text = "\(length.cm)"
            mmTextField.text = "\(length.mm)"
            yardTextField.text = "\(length.yard)"
            inchTextField.text = "\(length.inch)"
      

        case .mile:
            length.metre = Double(round((doubleTextFieldValue * 1609)*x)/x)
            length.km = Double(round((doubleTextFieldValue * 1.609)*x)/x)
            length.mile = doubleTextFieldValue
            length.cm = Double(round((doubleTextFieldValue * 160934)*x)/x)
            length.mm = Double(round((doubleTextFieldValue * 1609000)*x)/x)
            length.yard = Double(round((doubleTextFieldValue * 1760)*x)/x)
            length.inch = Double(round((doubleTextFieldValue * 63360)*x)/x)


            metreTextField.text = "\(length.metre)"
            kmTextField.text = "\(length.km)"
            cmTextField.text = "\(length.cm)"
            mmTextField.text = "\(length.mm)"
            yardTextField.text = "\(length.yard)"
            inchTextField.text = "\(length.inch)"
            
            
        case .cm:
            length.metre = Double(round((doubleTextFieldValue / 100)*x)/x)
            length.km = Double(round((doubleTextFieldValue / 100000)*x)/x)
            length.mile = Double(round((doubleTextFieldValue / 160934)*x)/x)
            length.cm = doubleTextFieldValue
            length.mm = Double(round((doubleTextFieldValue * 10)*x)/x)
            length.yard =  Double(round((doubleTextFieldValue / 91.44)*x)/x)
            length.inch = Double(round((doubleTextFieldValue / 2.54)*x)/x)

            metreTextField.text = "\(length.metre)"
            kmTextField.text = "\(length.km)"
            mileTextField.text = "\(length.mile)"
            mmTextField.text = "\(length.mm)"
            yardTextField.text = "\(length.yard)"
            inchTextField.text = "\(length.inch)"
    
        
        case .mm:
            length.metre = Double(round((doubleTextFieldValue / 1000)*x)/x)
            length.km = Double(round((doubleTextFieldValue / 1000000)*x)/x)
            length.mile = Double(round((doubleTextFieldValue / 1609000)*x)/x)
            length.cm = Double(round((doubleTextFieldValue / 10)*x)/x)
            length.mm = doubleTextFieldValue
            length.yard = Double(round((doubleTextFieldValue / 914)*x)/x)
            length.inch = Double(round((doubleTextFieldValue / 25.4)*x)/x)

            metreTextField.text = "\(length.metre)"
            kmTextField.text = "\(length.km)"
            mileTextField.text = "\(length.mile)"
            cmTextField.text = "\(length.cm)"
            yardTextField.text = "\(length.yard)"
            inchTextField.text = "\(length.inch)"
            
        
        case .yard:
            length.metre = Double(round((doubleTextFieldValue / 1.094)*x)/x)
            length.km = Double(round((doubleTextFieldValue / 1094)*x)/x)
            length.mile = Double(round((doubleTextFieldValue / 1760)*x)/x)
            length.cm = Double(round((doubleTextFieldValue * 91.44)*x)/x)
            length.mm = Double(round((doubleTextFieldValue * 914)*x)/x)
            length.yard = doubleTextFieldValue
            length.inch = Double(round((doubleTextFieldValue * 36)*x)/x)

            metreTextField.text = "\(length.metre)"
            kmTextField.text = "\(length.km)"
            mileTextField.text = "\(length.mile)"
            cmTextField.text = "\(length.cm)"
            mmTextField.text = "\(length.mm)"
            inchTextField.text = "\(length.inch)"
         
        case .inch:
            length.metre = Double(round((doubleTextFieldValue / 39.37)*x)/x)
            length.km = Double(round((doubleTextFieldValue / 39370)*x)/x)
            length.mile = Double(round((doubleTextFieldValue / 63360)*x)/x)
            length.cm = Double(round((doubleTextFieldValue * 2.54)*x)/x)
            length.mm = Double(round((doubleTextFieldValue * 25.4)*x)/x)
            length.yard = Double(round((doubleTextFieldValue / 36)*x)/x)
            length.inch = doubleTextFieldValue

            metreTextField.text = "\(length.metre)"
            kmTextField.text = "\(length.km)"
            mileTextField.text = "\(length.mile)"
            cmTextField.text = "\(length.cm)"
            mmTextField.text = "\(length.mm)"
            yardTextField.text = "\(length.yard)"
        }
        }
        else{
            metreTextField.text = ""
            kmTextField.text = ""
            mileTextField.text = ""
            cmTextField.text = ""
            mmTextField.text = ""
            yardTextField.text = ""
            inchTextField.text = ""
        }
    }
    
    
    func clear(){
        metreTextField.text = ""
        kmTextField.text = ""
        mileTextField.text = ""
        cmTextField.text = ""
        mmTextField.text = ""
        yardTextField.text = ""
        inchTextField.text = ""
    }
    
    
    @IBAction func saveValues(_ sender: UIButton) {
        
        if (metreTextField.text != "" && kmTextField.text != "" && mileTextField.text != "" && cmTextField.text != "" && mmTextField.text != "" && yardTextField.text != "" && inchTextField.text != ""  ){
        
        let defaults = UserDefaults.standard
        
            let historyString = "meter - \(length.metre)\n  km - \(length.km)\n mile- \(length.mile)\n cm- \(length.cm)\n mm- \(length.mm) \n yard- \(length.yard)\n inch- \(length.inch)"
        
            (length.metre, length.km, length.mile, length.cm, length.mm,length.yard,length.inch) = (0,0,0,0,0,0,0)
            
        
            if(defaults.object(forKey: "lengthHistory") != nil){
                length.historyArray = defaults.object(forKey: "lengthHistory")! as? [String]
            }
        
        if(length.historyArray.count > 4){
            length.historyArray.removeFirst()
            length.historyArray.append(historyString)
            defaults.set(length.historyArray, forKey: "lengthHistory")
            let alert = UIAlertController(title: "Great!", message: "successfully saved", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)
            clear()
          
        }else{
            length.historyArray.append(historyString)
            defaults.set(length.historyArray, forKey: "lengthHistory")
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
        metreTextField.text = ""
        kmTextField.text = ""
        mileTextField.text = ""
        cmTextField.text = ""
        mmTextField.text = ""
        yardTextField.text = ""
        inchTextField.text = ""
    }
    
}
