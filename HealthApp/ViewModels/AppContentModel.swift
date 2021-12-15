//
//  AppContentModel.swift
//  HealthApp
//
//  Created by Łukasz on 09/12/2021.
//

import Foundation
import FirebaseAuth

class SigningIn: ObservableObject{
    
    let auth = Auth.auth()
    
    @Published var signInSuccess = false
    @Published var error = false
    
    init(){
        if auth.currentUser != nil{
            signInSuccess = true
            print("AKTUALNY UŻYTKOWNIK ID:")
            print(auth.currentUser!.uid)
        }
    }
    
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
