//
//  Stats.swift
//  HealthApp
//
//  Created by Łukasz on 27/12/2021.
//

import Foundation
import SwiftUICharts

struct Stats: Identifiable{
    var id: String
    var name: String
    var namePL: String
    var unit: String
    var value: Double
    var goal: Double = 0
    var lastWeek: [DataPoint] = []
}
