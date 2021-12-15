//
//  MenuRow.swift
//  HealthApp
//
//  Created by Łukasz on 15/11/2021.
//

import SwiftUI

struct MenuRow<DestinationType: View>: View{
    var name: String
    var icon: String
    var destination: DestinationType
    
    @State private var selected: Bool? = false
    var body: some View {
        ZStack{
            NavigationLink(destination: self.destination, tag: true, selection: $selected){
                EmptyView()
            }.navigationBarTitle("Menu")
            Button(action: {
                self.selected = true
            }, label: {
                HStack{
                    Spacer()
                        .frame(width: 15)
                    Image(self.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.white)
                    Text(self.name)
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
            }).buttonStyle(MenuButtonStyle())
        }
    }
}


struct MenuRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0){
            MenuRow(name: "Pomiary ciała", icon: "body",
                    destination: MissingContenView())
            MenuRow(name: "Pomiary ciała", icon: "body",
                    destination: MissingContenView())
        }
        .cornerRadius(15)
    }
}
