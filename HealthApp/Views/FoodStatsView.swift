//
//  FoodStatsView.swift
//  HealthApp
//
//  Created by Łukasz on 10/12/2021.
//

import SwiftUI
import Combine

struct FoodStatsView: View {
    @State var progress: CGFloat = 0
    @State var text: String = "750 / 2500 kcal"
    
    @State var input: String = ""
    @State private var isEditing = false
    
    @EnvironmentObject var stats: CurrentStats
    @EnvironmentObject var currentUser: CurrentUser
    
    var body: some View {
        ScrollView{
            Spacer()
                .frame(height: 10)
            VStack(spacing: 30){
                Text("Dzienne")
                    .font(.system(size: 25,weight: .bold ,design: .serif))
                
                ProgressCircle(colors:[Color(red: 199/255, green: 141/255, blue: 32/255)],
                               width: 250,
                               height: 250,
                               textSize: 20,
                               textColor: Color.white,
                               lineWidth: 25,
                               progress: $progress,
                               text: $text)
                
                VStack(spacing: 15){
                    TextField("", text:self.$input)
                        .placeholder(when: input.isEmpty){
                            Text("Spożyte " + stats.namePL + "[" + stats.unit + "]")
                                .foregroundColor(.gray)
                                .font(.system(size: 25,weight: .bold ,design: .serif))
                        }
                        .keyboardType(.decimalPad)
                        .padding()
                        .frame(minWidth: 200, idealWidth: 340, maxWidth: 340, minHeight: 15)
                        .background(Color(.systemGray6))
                        .font(.system(size: 25,weight: .bold ,design: .serif))
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
                            self.currentUser.addValue(name: stats.name, value: inputD)
                            
                            self.progress = (stats.value + inputD) / nvl(value: stats.goal, newValue: stats.value)
                            
                            let progressValue = round(10 * self.progress * nvl(value: stats.goal, newValue: stats.value)) / 10
                            let goal = round(10 * stats.goal) / 10
                            
                            self.text = String(progressValue) + " / " + String(goal) + " " + stats.unit
                            
                            self.input = ""
                            self.isEditing = false
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            
                            currentUser.update()
                        }
                    }.buttonStyle(CustomButton2())
                }
                
                Text("Tygodniowe")
                    .font(.system(size: 25,weight: .bold ,design: .serif))
                
                Chart(points: stats.lasWeek)
                
            }
        }
        .navigationBarTitle(stats.namePL, displayMode: .inline)
        .toolbar{
            NavigationLink(destination: ProductsMenuView()){
                Text("Produkty")
            }
        }
        .onAppear(perform: {
            updateProgress()
        })
    }
    
    func updateProgress(){
        self.progress = stats.value / nvl(value: stats.goal, newValue: stats.value)
        let progressValue = round(10 * self.progress * nvl(value: stats.goal, newValue: stats.value)) / 10
        let goal = round(10 * stats.goal) / 10
        self.text = String(progressValue) + " / " + String(goal) + " " + stats.unit
    }
    
    func nvl(value: Double, newValue: Double) -> Double{
        if value == 0{
            return newValue
        }
        else{
            return value
        }
    }
}

struct FoodStatsView_Previews: PreviewProvider {
    static var previews: some View {
        FoodStatsView()
            .preferredColorScheme(.dark)
    }
}
