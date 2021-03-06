//
//  ContentView.swift
//  HealthApp
//
//  Created by Łukasz on 04/11/2021.
//

import SwiftUI

struct StartView: View {
    @State private var selection: String? = nil
    var body: some View {
        NavigationView{
            ZStack{
                NavigationLink(destination: LogInView(), tag: "A", selection: $selection){
                    EmptyView()
                }.navigationBarTitle("Wróć do Startu")
                
                NavigationLink(destination: MissingContenView(), tag: "B", selection: $selection){
                    EmptyView()
                }.navigationBarTitle("Wróć do Startu")
                
                VStack(spacing: 50){
                    Spacer()
                    
                    VStack(spacing: 30){
                        Image("Logo icon")
                        
                        Text("HealthApp")
                            .font(.system(size: 44,weight: .bold ,design: .serif))
                            .foregroundColor(.white)
                        
                    }
                    
                    VStack(spacing: 60){
                        Button("Zaloguj się"){
                            selection = "A"
                        }
                            .buttonStyle(CustomButton())
                            .accessibilityIdentifier("SignInNavButton")
                        
                        Button("Zarejestruj się"){
                            selection = "B"
                        }
                            .buttonStyle(CustomButton())
                            .accessibilityIdentifier("SignUpNavButton")
                    }
                    Spacer(minLength: 80)
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .preferredColorScheme(.dark)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

