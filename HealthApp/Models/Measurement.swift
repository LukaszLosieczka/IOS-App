//
//  Measurement.swift
//  HealthApp
//
//  Created by Łukasz on 27/12/2021.
//

import Foundation
import SwiftUI
import SwiftUICharts

struct Measurement: Identifiable{
    var id: String
    var name: String
    var namePL: String
    var unit: String
    @State var value: (String, Double) = ("", 0)
    @State var last7: [DataPoint] = []
}
