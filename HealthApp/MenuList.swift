//
//  MenuListView.swift
//  HealthApp
//
//  Created by Łukasz on 15/11/2021.
//

import SwiftUI

struct MenuList: View {
    var body: some View{
        VStack(spacing: 0){
            MenuRow(name:"Pomiary ciała", icon: "body",
                    destination: MissingContenView(text: "1"))
            MenuRow(name:"Odżywianie", icon: "food",
                    destination: MissingContenView(text: "2"))
            MenuRow(name:"Spożycie wody", icon: "water",
                    destination: MissingContenView(text: "3"))
            MenuRow(name:"Trening", icon: "fire",
                    destination: MissingContenView(text: "4"))
            MenuRow(name:"Sen", icon: "moon",
                    destination: MissingContenView(text: "5"))
            MenuRow(name:"Objawy", icon: "doctor",
                    destination: MissingContenView(text:"6"))
            MenuRow(name:"Parametry życiowe", icon: "heartbeat",
                    destination: MissingContenView(text: "7"))
        }
        .cornerRadius(15)
    }
}

struct MenuList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            MenuList()
        }
    }
}
