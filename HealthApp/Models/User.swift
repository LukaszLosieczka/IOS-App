//
//  User.swift
//  HealthApp
//
//  Created by Łukasz on 23/12/2021.
//

import Foundation
import SwiftUI

struct User{
    
    var id: String
    var name = "Użytkownik"
    var surname: String
    var email: String
    var image = "default-avatar"
    var waterGoal: Double
    var energyGoal: Double
    var trainingGoal: Double
    var days: [Day]
    
    init(dict: [String: Any], userId: String, userDays: [Day]){
        id = userId
        name = dict["name"] as? String ?? "Użytkownik"
        surname = dict["surname"] as? String ?? ""
        email = dict["email"] as? String ?? ""
        image = dict["image"] as? String ?? "default-avatar"
        waterGoal = dict["waterGoal"] as? Double ?? 0
        energyGoal = dict["energyGoal"] as? Double ?? 0
        trainingGoal = dict["trainingGoal"] as? Double ?? 0
        days = userDays.sorted{
            $0.hash > $1.hash
        }
    }
    
    func lastDay() -> Day{
        return days[0]
    }
}
