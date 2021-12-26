//
//  Product.swift
//  HealthApp
//
//  Created by Łukasz on 09/12/2021.
//

import Foundation

struct Product: Identifiable, Codable{
    var id: String
    var name: String = ""
    var carbohydrates: Double = 0
    var energy: Double = 0
    var fat: Double = 0
    var protein: Double = 0
    var sugars: Double = 0
    var water: Double = 0
}
