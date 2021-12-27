//
//  Chart.swift
//  HealthApp
//
//  Created by Łukasz on 27/12/2021.
//

import SwiftUI
import SwiftUICharts

struct Chart: View {
    @State var points: [DataPoint] = []
    var body: some View {
        Section{
            BarChartView(dataPoints: points)
                .frame(height: UIScreen.main.bounds.size.height/3)
                .padding()
        }
    }
}

struct Chart_Previews: PreviewProvider {
    static var previews: some View {
        
        Chart(points: [
            .init(value: 2, label: "21.12", legend: Legend(color:.red, label: "21.2021")),
            .init(value: 1, label: "21.12", legend: Legend(color:.blue, label: "21.2021")),
            .init(value: 3, label: "21.12", legend: Legend(color:.blue, label: "21.2021")),
            .init(value: 4, label: "21.12", legend: Legend(color:.blue, label: "21.2021")),
            .init(value: 4, label: "21.12", legend: Legend(color:.blue, label: "21.2021")),
            .init(value: 4, label: "21.12", legend: Legend(color:.blue, label: "21.2021")),
            .init(value: 4, label: "21.12", legend: Legend(color:.blue, label: "21.2021"))
        ])
            .preferredColorScheme(.dark)
    }
}
