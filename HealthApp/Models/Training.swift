//
//  Training.swift
//  HealthApp
//
//  Created by Łukasz on 09/12/2021.
//

import Foundation

struct Training: Identifiable, Codable {
    
    var id: String
    var name = ""
    var numberOfExercises: Int = 0
    var minutesOfExercises: Int = 0
    var minutesOfResting: Int = 0
    var caloriesBurned: Double = 0
    var image = ""
}
