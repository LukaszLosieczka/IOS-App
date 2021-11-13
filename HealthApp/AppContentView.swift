//
//  AppContentView.swift
//  HealthApp
//
//  Created by Łukasz on 13/11/2021.
//

import SwiftUI

class SigningIn: ObservableObject{
    @Published var signInSuccess = false
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
