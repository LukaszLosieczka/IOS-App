//
//  MeasurementDetailView.swift
//  HealthApp
//
//  Created by Łukasz on 27/12/2021.
//

import SwiftUI
import Combine

struct MeasurementDetailView: View {
    @EnvironmentObject var measurement: CurrentMeasurement
    @EnvironmentObject var currentUser: CurrentUser
    
    @State var input = ""
    @State private var isEditing = false
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(spacing: 10){
                
                Text(measurement.namePL)
                    .font(.system(size: 25,weight: .bold ,design: .serif))
                    .multilineTextAlignment(.leading)
                
                Chart2(points: measurement.last7)
                
                TextField("", text: $input)
                    .placeholder(when: input.isEmpty){
                        Text("Dodaj nową wartość")
                            .foregroundColor(.gray)
                            .font(.system(size: 25,weight: .bold ,design: .serif))
                    }
                    .padding()
                    .frame(minWidth: 150, idealWidth: 340, maxWidth: 340, minHeight: 15)
                    .font(.system(size: 25,weight: .bold ,design: .serif))
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .disableAutocorrection(true)
                    .keyboardType(.decimalPad)
                    .onTapGesture {
                        self.isEditing = true
                    }
                    .onReceive(Just(input)){ newInput in
                        let filtered = newInput.filter { ".0123456789".contains($0) }
                        
                        if filtered.components(separatedBy: ".").count - 1 > 1{
                            self.input = String(filtered.dropLast())
                        }
                        
                        else if filtered.prefix(1) == "."{
                            self.input = ""
                        }
                        
                        else if newInput != filtered{
                            self.input = filtered
                        }
                    }
                    .overlay(
                        HStack{
                            Spacer()
                            if isEditing {
                                Button(action: {
                                    self.isEditing = false
                                    self.input = ""
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }) {
                                    Text("Cancel")
                                }
                                .padding(.trailing, 10)
                                .transition(.move(edge: .trailing))
                            }
                        }
                    )
                                    
                Button("Dodaj"){
                    if !input.isEmpty{
                        let inputD = Double(input)!
                        
                        currentUser.changeMeasurement(name: measurement.name, value: inputD)
                        
                        self.input = ""
                        self.isEditing = false
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        
                        currentUser.update()
                    }
                }
                .buttonStyle(CustomButton2())
            }
        }
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct MeasurementDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MeasurementDetailView()
    }
}
