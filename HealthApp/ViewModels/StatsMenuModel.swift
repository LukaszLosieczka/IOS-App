//
//  StatsMenuModel.swift
//  HealthApp
//
//  Created by Łukasz on 27/12/2021.
//

import Foundation
import SwiftUICharts

class CurrentStats: ObservableObject{
    @Published var name: String = ""
    @Published var namePL: String = ""
    @Published var unit: String = ""
    @Published var value: Double = 0
    @Published var goal: Double = 0
    @Published var lasWeek: [DataPoint] = []
    
    func setParameters(name: String, namePL:String, unit: String, value: Double, goal:Double, lastWeek:[DataPoint]){
        self.name = name
        self.namePL = namePL
        self.unit = unit
        self.value = value
        self.goal = goal
        self.lasWeek = lastWeek
    }

}

class StatsList{
    var statsList: [Stats] = []
    
    init(){
        statsList = [
            Stats(id: "1", name:"carbo", namePL:"Węglowodany" , unit: "g", value: 0),
            Stats(id: "2", name:"energy", namePL:"Kalorie" , unit: "kcal", value: 0),
            Stats(id: "3", name:"fat", namePL:"Tłuszcze" , unit: "g", value: 0),
            Stats(id: "4", name:"protein", namePL:"Białko" , unit: "g", value: 0),
            Stats(id: "5", name:"sugars", namePL:"Cukry" , unit: "g", value: 0)
        ]
    }
}
