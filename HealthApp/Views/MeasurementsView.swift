//
//  MeasurementsView.swift
//  HealthApp
//
//  Created by Łukasz on 15/12/2021.
//

import SwiftUI

struct MeasurementsView: View {
    @State var date: String = getDate()
    
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(spacing: 30){
                DataPanelView(name: "Waga", unit: "kg", value: "80", date: $date)
                
                DataPanelView(name: "Wzrost", unit: "cm", value: "180", date: $date)
                
                DataPanelView(name: "Obwód talii", unit: "cm", value: "73", date: $date)
                
                DataPanelView(name: "Temperatura ciała", unit: "°C", value: "36.6", date: $date)
                
                DataPanelView(name: "Tkanka tłuszczowa", unit: "%", value: "--", date: $date)
                
                DataPanelView(name: "Wskaźnik masy ciała", unit: "BMI", value: "22.99", date: $date)
            }
        }
        .navigationBarTitle("Pomiary ciała")
        .onReceive(timer){ (_) in
            self.date = getDate()
        }
    }
}

struct MeasurementsView_Previews: PreviewProvider {
    static var previews: some View {
        MeasurementsView()
            .preferredColorScheme(.dark)
    }
}
