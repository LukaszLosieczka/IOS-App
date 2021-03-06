//
//  ProfileView.swift
//  HealthApp
//
//  Created by Łukasz on 14/11/2021.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var currentUser: CurrentUser
    
    @State private var loggedOut = false
    @State private var selection: String? = nil
    
    var body: some View {
        NavigationView{
            ZStack{
                NavigationLink(destination: MissingContenView(), tag: "A", selection: $selection){
                    EmptyView()
                }.navigationBarTitle("Profil")
                
                NavigationLink(destination: GoalSettingView(), tag: "B", selection: $selection){
                    EmptyView()
                }.navigationBarTitle("Profil")
                
                NavigationLink(destination: MissingContenView(), tag: "C", selection: $selection){
                    EmptyView()
                }.navigationBarTitle("Profil")
                
                VStack(spacing: 10){
                    Spacer()
                    HStack{
                        Spacer()
                        
                        Button("OK"){
                            dismiss()
                        }
                        .font(.system(size: 20, weight: .bold))
                        .accessibilityIdentifier("BackToMenuButton")
                        
                        Spacer()
                            .frame(width: 20)
                    }
                    ScrollView(.vertical, showsIndicators: false){
                        VStack{
                            Image(currentUser.user!.image)
                                .resizable()
                                .frame(width: 130, height: 130)
                                .clipShape(Circle())
                            
                            Text(currentUser.user!.name + " " + currentUser.user!.surname)
                                .font(.system(size: 40,weight: .bold ,design: .serif))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .accessibilityIdentifier("Profile")
                            
                        }
                        
                        VStack(spacing: 40){
                            Button("Edytuj profil"){
                                selection = "A"
                            }.buttonStyle(CustomButton())
                            
                            Button("Edytuj cele"){
                                selection = "B"
                            }.buttonStyle(CustomButton())
                                .accessibilityIdentifier("GoalsButton")
                            
                            Button("Ustawienia"){
                                selection = "C"
                            }.buttonStyle(CustomButton())
                            
                            Button("Wyloguj się"){
                                loggedOut.toggle()
                                dismiss()
                            }.buttonStyle(CustomButton())
                                .accessibilityIdentifier("SignOutButton")
                        }
                    }
                    
                    Spacer()
                }.preferredColorScheme(.dark)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .onDisappear{
                        if loggedOut{
                            currentUser.signOut()
                        }
                    }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
