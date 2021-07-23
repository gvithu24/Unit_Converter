//
//  Weight.swift
//  UnitConverter
//
//  Created by Vithushan Gnanaraj on 2021-03-09.
//

import Foundation

class Weight {
    
    var ounce : Double
    var pound : Double
    var gram : Double
    var stone : Double
    var stonePound : Double
    var kg : Double
    var historyArray : [String]!

    init(ounce: Double, pound: Double, gram: Double, stone: Double, stonePound: Double, kg: Double) {
        self.ounce = ounce
        self.pound = pound
        self.gram = gram
        self.stone = stone
        self.stonePound = stonePound
        self.kg = kg
        self.historyArray = [String]()
    }
    
    func getTemperature() -> String {
        return "\(self.ounce) ounce | \(self.pound) pound | \(self.gram) gram | \(self.stone) stone | \(self.stonePound) stonePound | \(self.kg) kg "
    }
}
