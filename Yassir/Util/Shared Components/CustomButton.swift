//
//  CustomButton.swift
//  Yassir
//
//  Created by Ahmed Aly on 11/02/2025.
//

import SwiftUI

struct CustomButton: View {
    let title: String;
    var height: CGFloat?
    var width: CGFloat?
    let action: () -> Void;
    
    var body: some View {
        Button(title) {
            action()
        }
        .buttonStyle(MyActionButtonStyle(height: height ?? 30, width: width ?? .infinity))
    }
}


struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(title: "Builder", action: {})
    }
}

struct MyActionButtonStyle: ButtonStyle {
    var height: CGFloat?;
    var width: CGFloat?
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.callout)
            .foregroundColor(.black)
            .frame(height: height ?? 30)
            .frame(maxWidth: width ?? .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.init(red: 0, green: 0, blue: 0, opacity: 0.1), lineWidth: 1)
            )
            .background(configuration.isPressed ? Color.init(red: 0, green: 0, blue: 0, opacity: 0.1) : Color.white)
            .cornerRadius(4)
           
    }
}
