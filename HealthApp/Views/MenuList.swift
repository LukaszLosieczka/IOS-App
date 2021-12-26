//
//  MenuListView.swift
//  HealthApp
//
//  Created by Łukasz on 15/11/2021.
//

import SwiftUI

struct MenuList: View {
    var body: some View{
        VStack(spacing: 0.45){
            MenuRow(name:"Pomiary ciała", icon: "body",
                    destination: MeasurementsView())
            MenuRow(name:"Odżywianie", icon: "food",
                    destination: FoodStatsView())
            MenuRow(name:"Spożycie wody", icon: "water",
                    destination: WaterStatsView())
            MenuRow(name: "Produkty", icon: "products",
                    destination: ProductsMenuView())
            MenuRow(name:"Trening", icon: "fire",
                    destination: TrainingMenuView())
//            MenuRow(name:"Sen", icon: "moon",
//                    destination: MissingContenView(text: "5"))
            MenuRow(name:"Objawy", icon: "doctor",
                    destination: SymptomsMenuView())
            MenuRow(name:"Parametry życiowe", icon: "heartbeat",
                    destination: MissingContenView(text: "7"))
        }
        .background(Color.gray)
        .cornerRadius(15)
    }
}

struct MenuList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            MenuList()
                .preferredColorScheme(.dark)
        }
    }
}
