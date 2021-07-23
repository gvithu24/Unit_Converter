//
//  Volume.swift
//  UnitConverter
//
//  Created by Vithushan Gnanaraj on 2021-03-12.
//

import Foundation

class Volume {
    
    var ukGallon : Double
    var litre : Double
    var ukPint : Double
    var fluidOunce : Double
    var millilitre : Double

    var historyArray : [String]!

    init(ukGallon: Double, litre: Double, ukPint: Double, fluidOunce: Double, millilitre: Double) {
        self.ukGallon = ukGallon
        self.litre = litre
        self.ukPint = ukPint
        self.fluidOunce = fluidOunce
        self.millilitre = millilitre
        self.historyArray = [String]()
    }
    
    func getTemperature() -> String {
        return "\(self.ukGallon) ukGallon | \(self.litre) litre | \(self.ukPint) ukPint | \(self.fluidOunce) fluidOunce | \(self.millilitre) millilitre"
    }
}
