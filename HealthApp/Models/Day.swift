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
    var fat: Double = 0
    var protein: Double = 0
    var sugars: Double = 0
    var hash: Int = 0
    
    init(dict: [String: Any], dayId: String){
        id = dayId
        date = dict["Date"] as? String ?? ""
        carbo = dict["Carbohydrates"] as? Double ?? 0
        energy = dict["Energy"] as? Double ?? 0
        training = dict["EnergyBurned"] as? Double ?? 0
        water = dict["Water"] as? Double ?? 0
        fat = dict["Fat"] as? Double ?? 0
        protein = dict["Protein"] as? Double ?? 0
        sugars = dict["Sugars"] as? Double ?? 0
        hash = generateHash(date: date)
    }
    
    init(date: String){
        self.id = date
        self.date = date
        self.hash = generateHash(date: date)
    }
    
    func generateHash(date: String) -> Int{
        let dateArr = date.components(separatedBy:".")
        
        let year = Int(dateArr[2]) ?? 0
        let month = Int(dateArr[1]) ?? 0
        let day = Int(dateArr[0]) ?? 0
        
        return (year * 10000) + (month * 100) + day
    }
    
    func getValue(name: String) ->Double{
        let n = name.lowercased()
        
        if n == "water"{
            return water
        }
        else if n == "energy"{
            return energy
        }
        else if n == "carbo"{
            return carbo
        }
        else if n == "training"{
            return training
        }
        else if n == "fat"{
            return fat
        }
        else if n == "protein"{
            return protein
        }
        else if n == "sugars"{
            return sugars
        }
        
        return 0
    }
    
}
