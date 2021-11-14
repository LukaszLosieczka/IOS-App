//
//  MenuView.swift
//  HealthApp
//
//  Created by Łukasz on 07/11/2021.
//

import SwiftUI

struct MenuView: View {
    @State private var showingProfile = false 
    var body: some View{
        NavigationView{
             VStack(){
                 HStack{
                     Text("HealthApp")
                         .font(.system(size: 40,weight: .bold ,design: .serif))
                         .foregroundColor(.white)
                     
                     Spacer()
                     
                     Button(action:{
                         showingProfile.toggle()
                     }){
                        Image("default-avatar")
                             .resizable()
                     }
                     .buttonStyle(CircleImageButton())
                     .sheet(isPresented: $showingProfile){
                         ProfileView()
                     }
                     
                 }
                 ScrollView(.vertical, showsIndicators: false){

                 }
             }
             .navigationBarTitle("")
             .navigationBarHidden(true)
         }
         .preferredColorScheme(.dark)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
