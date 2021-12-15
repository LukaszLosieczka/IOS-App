//
//  FoodStatsView.swift
//  HealthApp
//
//  Created by Łukasz on 10/12/2021.
//

import SwiftUI

struct FoodStatsView: View {
    @State var progress: CGFloat = 0.7
    @State var text: String = "750 / 2500 kcal"
    
    @State var foodInput: String = ""
    
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
                               textSize: 27,
                               textColor: Color.white,
                               lineWidth: 25,
                               progress: $progress,
                               text: $text)
                
                TextField("", text:self.$foodInput)
                    .placeholder(when: foodInput.isEmpty){
                        Text("Spożyte kalorie [kcal]")
                            .foregroundColor(.gray)
                            .font(.system(size: 28,weight: .bold ,design: .serif))
                    }
                    .padding()
                    .frame(minWidth: 200, idealWidth: 340, maxWidth: 340, idealHeight: 60)
                    .background(Color.white)
                    .font(.system(size: 28,weight: .bold ,design: .serif))
                    .foregroundColor(Color(UIColor.darkGray))
                    .cornerRadius(12)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                Button("Dodaj"){
                    
                }.buttonStyle(CustomButton())
                
            }
        }.navigationBarTitle("Odżywianie")
    }
}

struct FoodStatsView_Previews: PreviewProvider {
    static var previews: some View {
        FoodStatsView()
            .preferredColorScheme(.dark)
    }
}
