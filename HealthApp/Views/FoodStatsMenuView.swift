//
//  FoodStatsMenu.swift
//  HealthApp
//
//  Created by Łukasz on 27/12/2021.
//

import SwiftUI

struct FoodStatsMenuView: View {
    @State private var inProgress: Bool? = false
    
    @StateObject var stats = CurrentStats()
    @State var statsList = StatsList()
    
    @EnvironmentObject var currentUser: CurrentUser
    var body: some View {
        ScrollView(showsIndicators: false){
            ZStack{
                NavigationLink(destination: FoodStatsView().environmentObject(stats), tag: true, selection: $inProgress){
                    EmptyView()
                }
                HStack{
                    Spacer()
                    VStack(spacing: 0.5){
                        
                        ForEach(statsList.statsList, id: \.self.id){ s in
                            
                            Button(action:{
                                stats.setParameters(name: s.name,
                                                    namePL: s.namePL,
                                                    unit: s.unit,
                                                    value: (currentUser.user?.lastDay().getValue(name: s.name))!,
                                                    goal: (currentUser.user?.getGoal(name: s.name))!,
                                                    lastWeek: currentUser.user!.getWeekValues(name: s.name, namePL: s.namePL)
                                )
                                inProgress = true
                            }, label: {
                                HStack{
                                    Spacer()
                                        .frame(width: 15)
                                    Text(s.namePL)
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
        }.navigationTitle("Odżywianie")
    }
}

struct FoodStatsMenu_Previews: PreviewProvider {
    static var previews: some View {
        FoodStatsMenuView()
    }
}
