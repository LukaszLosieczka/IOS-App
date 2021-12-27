//
//  MeasurementsViewModel.swift
//  HealthApp
//
//  Created by Łukasz on 27/12/2021.
//

import Foundation
import SwiftUICharts

class CurrentMeasurement: ObservableObject{
    @Published var name: String = ""
    @Published var namePL: String = ""
    @Published var unit: String = ""
    @Published var last7: [DataPoint] = []
    
    func setParameters(name: String, namePL: String, unit: String, last7: [DataPoint]){
        self.name = name
        self.namePL = namePL
        self.unit = unit
        self.last7 = last7
    }
}

class MeasurementsList: ObservableObject{
    @Published var measurementsList: [Measurement] = []
    
    init(){
        measurementsList = [
            Measurement(id: "1", name:"weight", namePL:"Waga" , unit: "kg", value: ("", 0)),
            Measurement(id: "2", name:"height", namePL:"Wzrost" , unit: "cm", value: ("", 0)),
            Measurement(id: "3", name:"waist", namePL:"Obwód talii" , unit: "cm", value: ("", 0)),
            Measurement(id: "4", name:"temp", namePL:"Temperatura ciała" , unit: "°C", value: ("", 0)),
            Measurement(id: "5", name:"fatPerc", namePL:"Tkanka tłuszczowa" , unit: "%", value: ("", 0)),
            Measurement(id: "6", name:"bmi", namePL:"Wskaźnik masy ciała" , unit: "BMI", value: ("", 0))
        ]
    }
}
