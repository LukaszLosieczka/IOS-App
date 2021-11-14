//
//  ProfileView.swift
//  HealthApp
//
//  Created by Łukasz on 14/11/2021.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var signingIn: SigningIn
    
    @State private var loggedOut = false
    var body: some View {
        VStack(spacing: 30){
            Spacer()
            HStack{
                Spacer()
                
                Button("OK"){
                    dismiss()
                }
                .font(.system(size: 20, weight: .bold))
                
                Spacer()
                    .frame(width: 20)
            }
            ScrollView(.vertical, showsIndicators: false){
                Button("Wyloguj się"){
                    loggedOut.toggle()
                    dismiss()
                }.buttonStyle(CustomButton())
            }
        }.preferredColorScheme(.dark)
            .onDisappear{
                if loggedOut{
                        signingIn.signOut()
                }
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
