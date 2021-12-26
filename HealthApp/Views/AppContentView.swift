//
//  AppContentView.swift
//  HealthApp
//
//  Created by Łukasz on 13/11/2021.
//

import SwiftUI

struct AppContentView: View {
    
    @StateObject var currentUser = CurrentUser()
    
    var body: some View {
        return Group {
            if currentUser.sigingInSuccess && currentUser.user != nil{
                MenuView()
                    .environmentObject(currentUser)
            }
            else if currentUser.sigingInSuccess && currentUser.user == nil{
                LoadingView()
            }
            else {
                StartView()
                    .environmentObject(currentUser)
            }
        }
    }
}
