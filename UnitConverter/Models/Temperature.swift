//
//  Temperature.swift
//  UnitConverter
//
//  Created by Vithushan Gnanaraj on 2021-03-09.
//

import Foundation

class Temperature {
    
    var celsius : Double
    var farenheit : Double
    var kelvin : Double
    var historyArray : [String]!

    init(celsius: Double, farenheit: Double, kelvin: Double) {
        self.celsius = celsius
        self.farenheit = farenheit
        self.kelvin = kelvin
        self.historyArray = [String]()
    }
    
    func getTemperature() -> String {
        return "\(self.celsius) celsius | \(self.farenheit) farenhite | \(self.kelvin) kelvin "
    }
}
