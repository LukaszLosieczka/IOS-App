//
//  AppContentView.swift
//  HealthApp
//
//  Created by Łukasz on 13/11/2021.
//

import SwiftUI
import FirebaseAuth

class SigningIn: ObservableObject{
    
    let auth = Auth.auth()
    
    @Published var signInSuccess = false
    @Published var error = false
    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password){
            [weak self] result, error in
            if error != nil{
                DispatchQueue.main.async {
                    self?.error = true
                }
                print(error?.localizedDescription ?? "")
            }
            else{
                DispatchQueue.main.async {
                    self?.error = false
                    self?.signInSuccess = true
                }
                print("Successfull sign in")
            }
        }
    }
    
    func signOut(){
        try? auth.signOut()
        self.signInSuccess = false
        print("Successfull sign out")
    }
}

struct AppContentView: View {
    
    @StateObject var signingIn = SigningIn()
    
    var body: some View {
        return Group {
            if signingIn.signInSuccess {
                MenuView()
                    .environmentObject(signingIn)
            }
            else {
                StartView()
                    .environmentObject(signingIn)
            }
        }
    }
}

struct AppContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppContentView()
    }
}
