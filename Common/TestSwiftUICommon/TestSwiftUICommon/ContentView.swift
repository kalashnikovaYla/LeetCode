//
//  ContentView.swift
//  TestSwiftUICommon
//
//  Created by Юлия Калашникова on 04.10.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        Button("Нажми меня") {
        }
        .buttonStyle(CustomButtonStyle())
    }
}

#Preview {
    ContentView()
}


 

struct PressedEffectModifier: ViewModifier {
    var isPressed: Bool
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .background(isPressed ? Color.blue.opacity(0.7) : Color.blue) 
            .animation(.easeInOut(duration: 0.2), value: isPressed)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding()
    }
}

struct CustomPressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .modifier(PressedEffectModifier(isPressed: configuration.isPressed))
    }
}
 

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(configuration.isPressed ? Color.green.opacity(0.7) : Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.65 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
 
