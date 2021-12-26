//
//  Day.swift
//  HealthApp
//
//  Created by Łukasz on 23/12/2021.
//

import Foundation


struct Day{
    var id: String
    var date: String
    var carbo: Double = 0
    var energy: Double = 0
    var training: Double = 0
    var water: Double = 0
    var hash: Int = 0
    
    init(dict: [String: Any], dayId: String){
        id = dayId
        date = dict["Date"] as? String ?? ""
        carbo = dict["Carbohydrates"] as? Double ?? 0
        energy = dict["Energy"] as? Double ?? 0
        training = dict["EnergyBurned"] as? Double ?? 0
        water = dict["Water"] as? Double ?? 0
        hash = generateHash(date: date)
    }
    
    init(date: String){
        self.id = date
        self.date = date
    }
    
    private func generateHash(date: String) -> Int{
        let dateArr = date.components(separatedBy:".")
        
        let year = Int(dateArr[2]) ?? 0
        let month = Int(dateArr[1]) ?? 0
        let day = Int(dateArr[0]) ?? 0
        
        return (year * 1000) + (month * 100) + day
    }
    
}
