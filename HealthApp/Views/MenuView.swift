//
//  MenuView.swift
//  HealthApp
//
//  Created by Łukasz on 07/11/2021.
//

import SwiftUI

func getDate() -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    
    let date = Date()
    
    dateFormatter.locale = Locale(identifier: "pl_Pl")
    
    return dateFormatter.string(from: date)
}

struct MenuView: View {
    @State private var showingProfile = false
    @State private var date: String = getDate()
    
    @EnvironmentObject var currentUser: CurrentUser
    
    @State var currentDay: Day = Day(date: getDate())
    @State var goalsProgress: CGFloat = 0
    @State var progressText: String = "0%"
    
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    var body: some View{
        NavigationView{
            HStack{
                Spacer()
                    .frame(width: 10)
                
                VStack(spacing:15){
                    HStack{
                        Text("HealthApp")
                            .font(.system(size: 40,weight: .bold ,design: .serif))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button(action:{
                            showingProfile.toggle()
                        }){
                            Image(currentUser.user!.image)
                                .resizable()
                        }
                        .buttonStyle(CircleImageButton())
                        .sheet(isPresented: $showingProfile){
                            ProfileView()
                        }
                        
                    }
                    ScrollView(showsIndicators: false){
                        HStack{
                            Text("Witaj " + currentUser.user!.name + "!")
                                .font(.system(size: 25, weight: .bold, design: .serif))
                            Spacer()
                        }
                        
                        ZStack{
                            HStack{
                                Spacer()
                                    .frame(width: 8)
                                
                                VStack(alignment: .leading){
                                    Text("Realizacja")
                                    Text("celów")
                                    Spacer()
                                }
                                .font(.system(size: 18, weight: .bold, design: .serif))
                                .foregroundColor(Color(red: 204/255, green: 112/255, blue: 0/255))
                                
                                Spacer()
                                
                                ProgressCircle(progress: $goalsProgress, text: $progressText)
                                
                                Spacer()
                                
                                VStack{
                                    Text(date)
                                        .onReceive(timer){ (_) in
                                            let lastDate = self.date
                                            self.date = getDate()
                                            if lastDate != self.date{
                                                updateDay()
                                                checkProgress()
                                            }
                                        }
                                    Spacer()
                                }
                                .font(.system(size: 18, weight: .bold, design: .serif))
                                .foregroundColor(Color(red: 204/255, green: 112/255, blue: 0/255))
                                
                                Spacer()
                                    .frame(width: 8)
                            }
                        }
                        .frame(maxWidth: 380, minHeight: 180)
                        .background(Color.init(red: 30/255, green: 30/255, blue: 30/255))
                        .cornerRadius(15)
                        
                        Spacer()
                            .frame(height: 20)
                        
                        MenuList()
                    }
                }
                
                Spacer()
                    .frame(width: 10)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .onAppear(perform: {
                updateDay()
                checkProgress()
            })
            .onDisappear(perform: {
                if currentUser.sigingInSuccess{
                    currentUser.update()
                }
            })
         }
         .preferredColorScheme(.dark)
    }
    
    func updateDay(){
        currentDay = (currentUser.user?.lastDay())!
        
        if currentDay.date != date{
            let newDay = Day(date:date)
            if !((currentUser.user?.days.contains(where: { $0.hash == newDay.hash})) != nil){
                currentDay = newDay
                currentUser.addNewDay(day: newDay)
            }
        }
    }
    
    func checkProgress(){
        var goalsAchived:Double = 0
        
        if currentDay.water >= currentUser.user!.waterGoal{
            goalsAchived += 1
        }
        
        if currentDay.energy >= currentUser.user!.energyGoal{
            goalsAchived += 1
        }
        
        if currentDay.training >= currentUser.user!.trainingGoal{
            goalsAchived += 1
        }
        
        if currentDay.carbo >= currentUser.user!.carboGoal{
            goalsAchived += 1
        }
        
        if currentDay.protein >= currentUser.user!.proteinGoal{
            goalsAchived += 1
        }
        
        if currentDay.sugars >= currentUser.user!.sugarsGoal{
            goalsAchived += 1
        }
        
        if currentDay.fat >= currentUser.user!.fatGoal{
            goalsAchived += 1
        }
        
        let progress:Double = goalsAchived / 7.0
        self.goalsProgress = CGFloat(progress)
        self.progressText = String(Int(progress * 100)) + "%"
        
    }
}

//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView()
//    }
//}
