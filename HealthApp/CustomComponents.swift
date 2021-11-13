//
//  CustomComponents.swift
//  HealthApp
//
//  Created by Łukasz on 13/11/2021.
//

import SwiftUI

struct CustomButton: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 316, height: 66)
            .background(configuration.isPressed ? Color.gray : Color.init(red: 44/255, green: 44/255, blue: 44/255))
            .foregroundColor(.white)
            .cornerRadius(33)
            .font(.system(size: 30, weight: .bold, design: .serif))
    }
}
