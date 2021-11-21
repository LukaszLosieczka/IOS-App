//
//  MissingContenView.swift
//  HealthApp
//
//  Created by Łukasz on 13/11/2021.
//

import SwiftUI

struct MissingContenView: View {
    var text: String = ""
    var body: some View {
        VStack{
            Text("Missing content")
            Text(self.text)
        }
    }
}

struct MissingContenView_Previews: PreviewProvider {
    static var previews: some View {
        MissingContenView(text: "1")
    }
}
