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
    
    @State var goalsProgress: CGFloat = 0.5
    @State var progressText: String = "50%"
    
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
                            Image("default-avatar")
                                .resizable()
                        }
                        .buttonStyle(CircleImageButton())
                        .sheet(isPresented: $showingProfile){
                            ProfileView()
                        }
                        
                    }
                    ScrollView(showsIndicators: false){
                        HStack{
                            Text("Witaj Użytkowniku!")
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
                                            self.date = getDate()
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
         }
         .preferredColorScheme(.dark)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}