//
//  User.swift
//  HealthApp
//
//  Created by Łukasz on 23/12/2021.
//

import Foundation
import SwiftUI
import SwiftUICharts

struct User{
    
    var id: String
    var name = "Użytkownik"
    var surname: String
    var email: String
    var image = "default-avatar"
    
    var weight: [String: Double]
    var height: [String: Double]
    var waist: [String: Double]
    var temp: [String: Double]
    var fatPerc: [String: Double]
    var bmi: [String: Double]
    
    var waterGoal: Double
    var energyGoal: Double
    var trainingGoal: Double
    var carboGoal: Double
    var fatGoal: Double
    var proteinGoal: Double
    var sugarsGoal: Double
    
    var days: [Day]
    
    init(dict: [String: Any], userId: String, userDays: [Day]){
        id = userId
        name = dict["name"] as? String ?? "Użytkownik"
        surname = dict["surname"] as? String ?? ""
        email = dict["email"] as? String ?? ""
        image = dict["image"] as? String ?? "default-avatar"
        
        weight = dict["weight"] as? [String:Double] ?? [:]
        height = dict["height"] as? [String:Double] ?? [:]
        waist = dict["waist"] as? [String:Double] ?? [:]
        temp = dict["temp"] as? [String:Double] ?? [:]
        fatPerc = dict["fatPerc"] as? [String:Double] ?? [:]
        bmi = dict["bmi"] as? [String:Double] ?? [:]
        
        waterGoal = dict["waterGoal"] as? Double ?? 0
        energyGoal = dict["energyGoal"] as? Double ?? 0
        trainingGoal = dict["trainingGoal"] as? Double ?? 0
        carboGoal = dict["carboGoal"] as? Double ?? 0
        fatGoal = dict["fatGoal"] as? Double ?? 0
        proteinGoal = dict["proteinGoal"] as? Double ?? 0
        sugarsGoal = dict["sugarsGoal"] as? Double ?? 0
        
        days = userDays.sorted{
            $0.hash > $1.hash
        }
    }
    
    func getMeasurement(name:String) -> [String:Double]{
        if name == "weight"{
            return weight
        }
        else if name == "height"{
            return height
        }
        else if name == "waist"{
            return waist
        }
        else if name == "temp"{
            return temp
        }
        else if name == "fatPerc"{
            return fatPerc
        }
        else if name == "bmi"{
            return bmi
        }
        return [:]
    }
    
    func getLastMeasurement(name: String) -> (String, Double){
        let measurements = getMeasurement(name: name)
        
        let sorted =  Array(measurements.keys).sorted{
             Day(date:$0).hash > Day(date:$1).hash
         }
         
         return (sorted[0], measurements[sorted[0]]!)
    }
    
    func getLast7Measurements(name: String, namePL: String) -> [DataPoint]{
        let measurements = getMeasurement(name: name)
    
        let sorted =  Array(measurements.keys).sorted{
            Day(date:$0).hash > Day(date:$1).hash
        }
        
        var datapoints: [DataPoint] = []
        let legend = Legend(color: .blue, label: LocalizedStringKey(namePL))
        
        for n in 0...6{
            if n > sorted.count - 1{
                datapoints.append(DataPoint(value: 0, label: "--.--", legend: legend))
            }
            else{
                let value = measurements[sorted[n]]
                let dateA = sorted[n].components(separatedBy: ".")
                let date = String(dateA[0]) + "." + String(dateA[1])
                datapoints.append(DataPoint(value:value! , label: LocalizedStringKey(date), legend: legend))
            }
        }
        
        return datapoints.reversed()
    }
    
    func getWeekValues(name: String, namePL: String) -> [DataPoint]{
        var datapoints: [DataPoint] = []
        var color:Color = Color(red: 199/255, green: 141/255, blue: 32/255)
        
        if name == "water"{
            color = .blue
        }
            
        let legend = Legend(color: color, label: LocalizedStringKey(namePL))
        let week = getLastWeek()
        
        let userDays = days
        
        for d in week{
            
            if let day = userDays.first(where: { $0.hash == Day(date: d).hash}){
                let value = day.getValue(name: name)
                let dateA = day.date.components(separatedBy: ".")
                let date = String(dateA[0]) + "." + String(dateA[1])
                datapoints.append(DataPoint(value:value, label: LocalizedStringKey(date), legend: legend))
            }
            else{
                let dateA = d.components(separatedBy: ".")
                let date = String(dateA[0]) + "." + String(dateA[1])
                datapoints.append(DataPoint(value: 0, label: LocalizedStringKey(date), legend: legend))
            }
        }
            
//        for n in 0...6{
//            if n > (user?.days.count)! - 1{
//                datapoints.append(DataPoint(value: 0, label: "", legend: legend))
//            }
//            else{
//                let value = user?.days[n].getValue(name: name)
//                let dateA = user?.days[n].date.components(separatedBy: ".")
//                let date = String(dateA![0]) + "." + String(dateA![1])
//                datapoints.append(DataPoint(value:value! , label: LocalizedStringKey(date), legend: legend))
//            }
//        }
        
        return datapoints.reversed()
    }
    
    private func getLastWeek() -> [String]{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "pl_Pl")
        
        var week:[String] = []
        
        var lastDate = Date().dayBefore
        
        for _ in 1...7{
            if week.count == 0{
                week.append(dateFormatter.string(from: lastDate))
            }
            else{
                let dayBefore = lastDate.dayBefore
                week.append(dateFormatter.string(from: dayBefore))
                lastDate = dayBefore
            }
        }
        return week
    }
    
    
    func getGoal(name: String) -> Double{
        let n = name.lowercased()
        
        if n == "water"{
            return waterGoal
        }
        else if n == "energy"{
            return energyGoal
        }
        else if n == "carbo"{
            return carboGoal
        }
        else if n == "training"{
            return trainingGoal
        }
        else if n == "fat"{
            return fatGoal
        }
        else if n == "protein"{
            return proteinGoal
        }
        else if n == "sugars"{
            return sugarsGoal
        }
        
        return 0
    }
    
    func lastDay() -> Day{
        return days[0]
    }
}
