//
//  MissingContenView.swift
//  HealthApp
//
//  Created by Łukasz on 13/11/2021.
//

import SwiftUI

struct MissingContenView: View {
    var body: some View {
        ZStack{
            Color(red: 0, green: 0, blue: 0).ignoresSafeArea()
            Text("Missing content")
        }
    }
}

struct MissingContenView_Previews: PreviewProvider {
    static var previews: some View {
        MissingContenView()
    }
}
