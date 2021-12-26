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

struct CustomButton2: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 250, height: 50)
            .background(configuration.isPressed ? Color.gray : Color.init(red: 44/255, green: 44/255, blue: 44/255))
            .foregroundColor(.white)
            .cornerRadius(33)
            .font(.system(size: 25, weight: .bold, design: .serif))
    }
}

struct CircleImageButton: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 55, height: 55)
            .clipShape(Circle())
            .grayscale(configuration.isPressed ? 1 : 0)
    }
}

struct TrainingButton: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 200, height: 55)
            .background(configuration.isPressed ? Color.gray : Color.init(red: 44/255, green: 44/255, blue: 44/255))
            .foregroundColor(.white)
            .cornerRadius(33)
            .font(.system(size: 25, weight: .bold, design: .serif))
    }
}

struct MenuButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color.gray : Color.init(red: 30/255, green: 30/255, blue: 30/255))
    }
}
