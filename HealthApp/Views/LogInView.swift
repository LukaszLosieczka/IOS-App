//
//  LogInView.swift
//  HealthApp
//
//  Created by Łukasz on 07/11/2021.
//

import SwiftUI

struct LogInView: View {
    @State private var email = ""
    @State private var password = ""
    
    @EnvironmentObject var currentUser: CurrentUser
    
    var body: some View {
        ScrollView(showsIndicators: false){
            
            VStack(spacing: 30){
                Image("Logo icon")
                    .resizable()
                    .frame(width:100,height: 100)
                
                Text("HealthApp")
                    .font(.system(size: 36,weight: .bold ,design: .serif))
                    .foregroundColor(.white)
                
            }
            
            Spacer(minLength: 40)
            
            VStack(spacing: 50){
                
                TextField("", text:self.$email)
                    .placeholder(when: email.isEmpty){
                        Text("Email").foregroundColor(.gray)
                        .font(.system(size: 30,weight: .bold ,design: .serif))}
                    .padding()
                    .frame(minWidth: 200, idealWidth: 375, maxWidth: 375, idealHeight: 60)
                    .background(Color.white)
                    .font(.system(size: 30,weight: .bold ,design: .serif))
                    .foregroundColor(Color(UIColor.darkGray))
                    .cornerRadius(12)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .accessibilityIdentifier("EmailTextField")
                
                SecureField("Hasło", text:self.$password)
                    .placeholder(when: password.isEmpty){
                        Text("Hasło").foregroundColor(.gray)
                        .font(.system(size: 30,weight: .bold ,design: .serif))}
                    .padding()
                    .frame(minWidth: 200, idealWidth: 375, maxWidth: 375, idealHeight: 60)
                    .background(Color.white)
                    .font(.system(size: 30,weight: .bold ,design: .serif))
                    .foregroundColor(Color(UIColor.darkGray))
                    .cornerRadius(12)
                    .accessibilityIdentifier("PasswordTextField")
                
            }
            
            Spacer(minLength: 40)
            
            Button("Zaloguj się"){
                guard !email.isEmpty, !password.isEmpty else{
                    return
                }
                
                currentUser.signIn(email: email, password: password)
            }
            .buttonStyle(CustomButton())
            .alert("Email lub hasło są niepoprawne", isPresented: $currentUser.error){
                Button("OK"){
                    self.email = ""
                    self.password = ""
                }
            }
            .accessibilityIdentifier("SignInButton")
            
            Spacer()
                .frame(height: 50)
            
        }.preferredColorScheme(.dark)
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
