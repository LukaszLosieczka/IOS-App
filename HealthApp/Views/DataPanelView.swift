//
//  DataPanelView.swift
//  HealthApp
//
//  Created by Łukasz on 15/12/2021.
//

import SwiftUI

struct DataPanelView: View {
    var name: String
    var unit: String
    var value: String
    @Binding var date: String
    
    var body: some View {
        VStack{
            Spacer()
                .frame(height:10)
            HStack(){
                Spacer()
                    .frame(width: 5)
                VStack{
                    HStack{
                        Text(name)
                            .font(.system(size: 16, weight: .bold, design: .serif))
                            .foregroundColor(Color(red: 199/255, green: 141/255, blue: 32/255))
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    .frame(maxWidth: 115)
                    Spacer()
                }
                
                Spacer()
                
                HStack(spacing: 20){
                    Text(value)
                        .font(.system(size: 23, weight: .bold, design: .serif))
                        .foregroundColor(Color.white)
                    Text(unit)
                        .font(.system(size: 23, weight: .bold, design: .serif))
                        .foregroundColor(Color.gray)
                }
                
                Spacer()
                
                VStack{
                    Text(date)
                        .font(.system(size: 16, weight: .bold, design: .serif))
                        .foregroundColor(Color.white)
                    Spacer()
                }
                
                Spacer()
                    .frame(width: 5)
            }
            Spacer()
                .frame(height:10)
        }
        .frame(maxWidth: 360, minHeight: 80, maxHeight: 80)
        .background(Color.init(red: 30/255, green: 30/255, blue: 30/255))
        .cornerRadius(15)
    }
}

//struct DataPanelView_Previews: PreviewProvider {
//    static var previews: some View {
//        DataPanelView(name: "Waga", unit: "kg", value: "80", date: "15.12.2021")
//    }
//}
