//
//  ProgressCircle.swift
//  HealthApp
//
//  Created by Łukasz on 10/12/2021.
//

import SwiftUI

struct ProgressCircle: View {
    var colors: [Color] = [Color(red:102/255, green:0/255, blue:0/255),
                          Color(red:204/255, green:102/255, blue:0/255),
                          Color(red:204/255, green:204/255, blue:0/255)]
    var width: CGFloat = 130
    var height: CGFloat = 130
    var textSize: CGFloat = 30
    var textColor: Color = Color(red: 204/255,green: 112/255,blue: 0/255)
    var lineWidth: CGFloat = 18
    
    @Binding var progress: CGFloat
    @Binding var text: String
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(Color.white.opacity(0.3),
                        style: StrokeStyle(lineWidth: lineWidth))
                .frame(width: width, height: height)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(LinearGradient(gradient:Gradient(colors: colors),
                                       startPoint: .leading, endPoint: .trailing),
                        style: StrokeStyle(lineWidth: lineWidth))
                .frame(width: width, height: height)
                .rotationEffect(.init(degrees: -90))
            
            Text(text)
                .font(.system(size: textSize, weight: .bold, design: .serif))
                .foregroundColor(textColor)
        }
    }
}

//struct ProgressCircle_Previews: PreviewProvider {
//    static var previews: some View {
//        ProgressCircle()
//    }
//}
