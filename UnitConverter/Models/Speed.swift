//
//  Speed.swift
//  UnitConverter
//
//  Created by Vithushan Gnanaraj on 2021-03-12.
//

import Foundation

class Speed {
    
    var metreSec : Double
    var kmHour : Double
    var mileHour : Double
    var nauticalMileHour : Double

    var historyArray : [String]!

    init(metreSec: Double, kmHour: Double, mileHour: Double, nauticalMileHour: Double) {
        self.metreSec = metreSec
        self.kmHour = kmHour
        self.mileHour = mileHour
        self.nauticalMileHour = nauticalMileHour
        self.historyArray = [String]()
    }
    
    func getTemperature() -> String {
        return "\(self.metreSec) metreSec | \(self.kmHour) kmHour | \(self.mileHour) mileHour | \(self.nauticalMileHour) nauticalMileHour"
    }
}
