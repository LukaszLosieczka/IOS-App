//
//  Chart2.swift
//  HealthApp
//
//  Created by Łukasz on 27/12/2021.
//

import SwiftUI
import SwiftUICharts

struct Chart2: View {
    @State var points: [DataPoint] = []
    var body: some View {
        Section{
            BarChartView(dataPoints: points)
                .frame(height: UIScreen.main.bounds.size.height/2)
                .padding()
        }
    }
}

struct Chart2_Previews: PreviewProvider {
    static var previews: some View {
        Chart2()
    }
}
