//
//  WaterStatsView.swift
//  HealthApp
//
//  Created by Łukasz on 10/12/2021.
//

import SwiftUI

struct WaterStatsView: View {
    @State var progress: CGFloat = 0.7
    @State var text: String = "1.4 / 2.0 l"
    
    @State var waterInput: String = ""
    
    var body: some View {
        ScrollView{
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
                
                TextField("", text:self.$waterInput)
                    .placeholder(when: waterInput.isEmpty){
                        Text("Wypita woda [ml]")
                            .foregroundColor(.gray)
                            .font(.system(size: 30,weight: .bold ,design: .serif))
                    }
                    .padding()
                    .frame(minWidth: 200, idealWidth: 340, maxWidth: 340, idealHeight: 60)
                    .background(Color.white)
                    .font(.system(size: 30,weight: .bold ,design: .serif))
                    .foregroundColor(Color(UIColor.darkGray))
                    .cornerRadius(12)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                Button("Dodaj"){
                    
                }.buttonStyle(CustomButton())
                
            }
        }.navigationBarTitle("Spożycie wody")
    }
}

struct WaterStatsView_Previews: PreviewProvider {
    static var previews: some View {
        WaterStatsView()
            .preferredColorScheme(.dark)
    }
}
