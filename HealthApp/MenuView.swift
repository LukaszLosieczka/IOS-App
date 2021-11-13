//
//  MenuView.swift
//  HealthApp
//
//  Created by Łukasz on 07/11/2021.
//

import SwiftUI

struct MenuView: View {
    
    @EnvironmentObject var signingIn: SigningIn
    var body: some View{
        NavigationView{
            Text("Menu")
        }.preferredColorScheme(.dark)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
