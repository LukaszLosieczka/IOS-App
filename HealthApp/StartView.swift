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
                }
                NavigationLink(destination: MissingContenView(), tag: "B", selection: $selection){
                    EmptyView()
                }
                
                VStack(spacing: 50){
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
                        Button("Zarejestruj się"){
                            selection = "B"
                        }
                            .buttonStyle(CustomButton())
                    }
                    Spacer(minLength: 80)
                }

            }
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

