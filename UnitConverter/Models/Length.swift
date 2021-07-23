//
//  Length.swift
//  UnitConverter
//
//  Created by Vithushan Gnanaraj on 2021-03-12.
//

import Foundation

class Length {
    
    var metre : Double
    var km : Double
    var mile : Double
    var cm : Double
    var mm : Double
    var yard : Double
    var inch : Double

    var historyArray : [String]!

    init(metre: Double, km: Double, mile: Double, cm: Double, mm: Double, yard: Double, inch: Double) {
        self.metre = metre
        self.km = km
        self.mile = mile
        self.cm = cm
        self.mm = mm
        self.yard = yard
        self.inch = inch
        
        self.historyArray = [String]()
    }
    
    func getTemperature() -> String {
        return "\(self.metre) metre | \(self.km) km | \(self.mile) mile | \(self.cm) cm | \(self.mm) mm | \(self.yard) yard | \(self.inch) inch"
    }
}
