//
//  LoadingView.swift
//  HealthApp
//
//  Created by Łukasz on 25/12/2021.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 100){
            VStack(spacing: 30){
                Image("Logo icon")
                
                Text("HealthApp")
                    .font(.system(size: 44,weight: .bold ,design: .serif))
                    .foregroundColor(.white)
                
            }
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(3)
        }
        .preferredColorScheme(.dark)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
