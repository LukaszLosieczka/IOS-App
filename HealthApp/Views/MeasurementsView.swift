//
//  MeasurementsView.swift
//  HealthApp
//
//  Created by Łukasz on 15/12/2021.
//

import SwiftUI

struct MeasurementsView: View {
    @State private var inProgress: Bool? = false
    
    @StateObject var measurement = CurrentMeasurement()
    @StateObject var list = MeasurementsList()
    
    @EnvironmentObject var currentUser: CurrentUser
    
    init(){
        
    }
    
    var body: some View {
        ScrollView(showsIndicators: false){
            ZStack{
                NavigationLink(destination: MeasurementDetailView().environmentObject(measurement), tag: true, selection: $inProgress){
                    EmptyView()
                }
                
                VStack(spacing: 30){
                    ForEach(list.measurementsList, id: \.self.id){ m in
                        DataPanelView(name: m.namePL, unit: m.unit, value: String((currentUser.user?.getLastMeasurement(name: m.name).1)!),
                                      date: String((currentUser.user?.getLastMeasurement(name: m.name).0)!))
                            .onTapGesture {
                                measurement.setParameters(name: m.name,
                                                          namePL: m.namePL,
                                                          unit: m.unit,
                                                          last7: (currentUser.user?.getLast7Measurements(name: m.name, namePL: m.namePL))!)
                                self.inProgress = true
                            }
                    }
                }
            }
        }
        .navigationBarTitle("Pomiary ciała")
    }
}

struct MeasurementsView_Previews: PreviewProvider {
    static var previews: some View {
        MeasurementsView()
            .preferredColorScheme(.dark)
    }
}
