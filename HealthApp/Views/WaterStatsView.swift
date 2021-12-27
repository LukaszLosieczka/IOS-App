//
//  WaterStatsView.swift
//  HealthApp
//
//  Created by Łukasz on 10/12/2021.
//

import SwiftUI
import Combine

struct WaterStatsView: View {
    @State var progress: CGFloat = 0
    @State var text: String = "0.0 / 2.0 l"
    
    @State var input = ""
    @State private var isEditing = false
    
    @EnvironmentObject var currentUser: CurrentUser
    
    var body: some View {
        ScrollView(showsIndicators: false){
            Spacer()
                .frame(height: 10)
            VStack(spacing: 30){
    
                Text("Dzienne")
                    .font(.system(size: 25,weight: .bold ,design: .serif))
                
                ProgressCircle(colors:[Color.blue],
                               width: 250,
                               height: 250,
                               textSize: 30,
                               textColor: Color.white,
                               lineWidth: 25,
                               progress: $progress,
                               text: $text)
                
                VStack(spacing: 15){
                    TextField("", text: $input)
                        .placeholder(when: input.isEmpty){
                            Text("Wypita woda [ml]")
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
                            self.currentUser.addValue(name: "water", value: inputD)
                            
                            self.progress = ((currentUser.user?.lastDay().water)! + inputD) / currentUser.user!.waterGoal
                            
                            let progressValue = round(10 * self.progress * currentUser.user!.waterGoal) / 10
                            let goal = round(10 * currentUser.user!.waterGoal) / 10
                            
                            self.text = String(progressValue) + " / " + String(goal/1000) + " l"
                            
                            self.input = ""
                            self.isEditing = false
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            
                            currentUser.update()
                        }
                    }
                    .buttonStyle(CustomButton2())
                }
                
                Text("Tygodniowe")
                    .font(.system(size: 25,weight: .bold ,design: .serif))
                
                Chart(points: currentUser.user!.getWeekValues(name: "water", namePL: "Woda"))
            }
        }
        .navigationBarTitle("Spożycie wody", displayMode: .inline)
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
        self.progress = (currentUser.user?.lastDay().water)! / currentUser.user!.waterGoal
        let progressValue = round(10 * self.progress * currentUser.user!.waterGoal) / 10
        let goal = round(10 * currentUser.user!.waterGoal) / 10
        self.text = String(progressValue/1000) + " / " + String(goal/1000) + " l"
    }
}

struct WaterStatsView_Previews: PreviewProvider {
    static var previews: some View {
        WaterStatsView()
            .preferredColorScheme(.dark)
    }
}
