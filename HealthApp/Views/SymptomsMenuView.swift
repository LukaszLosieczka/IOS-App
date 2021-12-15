//
//  SymptomsMenuView.swift
//  HealthApp
//
//  Created by Łukasz on 12/12/2021.
//

import SwiftUI

struct SymptomsMenuView: View {
    @StateObject var symptom = CurrentSymptom()
    @StateObject var symptoms = SymptomsList()
    
    @State private var inProgress: Bool? = false
    var body: some View {
        ScrollView(showsIndicators: false){
            ZStack{
                NavigationLink(destination: SymptomView().environmentObject(symptom), tag: true, selection: $inProgress){
                    EmptyView()
                }
                HStack{
                    Spacer()
                    VStack(spacing: 0.5){
                        
                        ForEach(symptoms.symptomsList, id: \.self.id){ s in
                            
                            Button(action:{
                                symptom.setParameters(name: s.name,
                                                      depiction: s.depiction,
                                                      treatment: s.treatment)
                                inProgress = true
                            }, label: {
                                HStack{
                                    Spacer()
                                        .frame(width: 15)
                                    Text(s.name)
                                        .font(.system(size: 23, weight: .bold, design: .serif))
                                        .foregroundColor(Color.white)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 7)
                                        .foregroundColor(Color.white)
                                    Spacer()
                                        .frame(width: 20)
                                }
                                .frame(maxWidth: 380, minHeight: 60)
                            })
                                .buttonStyle(MenuButtonStyle())
                            
                        }
                    }
                    .background(Color.gray)
                    .cornerRadius(15)
                    Spacer()
                }
            }
        }.navigationTitle("Objawy")
            .onAppear {
                symptoms.updateData()
            }
    }
}

struct SymptomsMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SymptomsMenuView()
    }
}
