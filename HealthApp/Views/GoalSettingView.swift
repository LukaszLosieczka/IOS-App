//
//  GoalSettingView.swift
//  HealthApp
//
//  Created by Łukasz on 28/12/2021.
//

import SwiftUI
import Combine

struct GoalSettingView: View {
    @State private var selection = "water"
    @State private var text = "Cel nawodnienia"
    @State private var text2 = ""
    @State private var unit = ""
    
    @State var input = ""
    @State private var isEditing = false
    
    @EnvironmentObject var currentUser: CurrentUser
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(spacing: 50){
                HStack {
                    Text(text)
                        .font(.system(size: 25, weight: .bold, design: .serif))
                    Menu {
                        Button {
                            selection = "water"
                            text = "Cel nawodnienia"
                            text2 = String((currentUser.user?.getGoal(name: selection))!) + "[ml]"
                            unit = "[ml]"
                        } label: {
                            Text("Cel nawodnienia")
                        }
                        Button {
                            selection = "energy"
                            text = "Cel kaloryczny"
                            text2 = String((currentUser.user?.getGoal(name: selection))!) + "[kcal]"
                            unit = "[kcal]"
                        } label: {
                            Text("Cel kaloryczny")
                        }
                        Button {
                            selection = "training"
                            text = "Cel treningowy"
                            text2 = String((currentUser.user?.getGoal(name: selection))!) + "[kcal]"
                            unit = "[kcal]"
                        } label: {
                            Text("Cel treningowy")
                        }
                        Button {
                            selection = "sugars"
                            text = "Cel: cukier"
                            text2 = String((currentUser.user?.getGoal(name: selection))!) + "[g]"
                            unit = "[g]"
                        } label: {
                            Text("Cel: cukier")
                        }
                        Button {
                            selection = "protein"
                            text = "Cel: białko"
                            text2 = String((currentUser.user?.getGoal(name: selection))!) + "[g]"
                            unit = "[g]"
                        } label: {
                            Text("Cel: białko")
                        }
                        Button {
                            selection = "fat"
                            text = "Cel: tłuszcze"
                            text2 = String((currentUser.user?.getGoal(name: selection))!) + "[g]"
                            unit = "[g]"
                        } label: {
                            Text("Cel: tłuszcze")
                        }
                        Button {
                            selection = "carbo"
                            text = "Cel: Węglowodany"
                            text2 = String((currentUser.user?.getGoal(name: selection))!) + "[g]"
                            unit = "[g]"
                        } label: {
                            Text("Cel: Węglowodany")
                        }
                        
                    } label: {
                        Image(systemName: "tag.circle")
                    }
                }
                .padding()
                .frame(minWidth: 150, idealWidth: 340, maxWidth: 340, minHeight: 15)
                .background(Color(.systemGray5))
                .cornerRadius(12)
                
                TextField("", text: $input)
                    .placeholder(when: input.isEmpty){
                        Text(text2)
                            .foregroundColor(.gray)
                            .font(.system(size: 25,weight: .bold ,design: .serif))
                    }
                    .padding()
                    .frame(minWidth: 150, idealWidth: 340, maxWidth: 340, minHeight: 15)
                    .font(.system(size: 25,weight: .bold ,design: .serif))
                    .background(Color(.systemGray3))
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
                
                Button("Zmień"){
                    if !input.isEmpty{
                        let inputD = Double(input)!
                        self.currentUser.changeGoal(name: selection + "Goal", value: inputD)
                        text2 = String(inputD) + unit
                        
                        self.input = ""
                        self.isEditing = false
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        
                        currentUser.update()
                    }
                }
                .buttonStyle(CustomButton2())
            }
            .onAppear(perform: {
                text2 = String((currentUser.user?.getGoal(name: selection))!) + "[ml]"
                unit = "[ml]"
            })
            
        }
        .navigationBarTitle("Edytuj cele")
    }
}

struct GoalSettingView_Previews: PreviewProvider {
    static var previews: some View {
        GoalSettingView()
            .preferredColorScheme(.dark)
    }
}
