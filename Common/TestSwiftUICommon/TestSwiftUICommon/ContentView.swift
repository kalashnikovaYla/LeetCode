//
//  ContentView.swift
//  TestSwiftUICommon
//
//  Created by Юлия Калашникова on 04.10.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var text: String = ""
    
    var body: some View {
        TextField("Введите текст", text: $text)
            .modifier(InputBorderAndColorModifier())
            .padding()
        
        Button("Нажми меня") {}
        .buttonStyle(CustomButtonStyle())
    }
}

#Preview {
    ContentView()
}
 
//MARK: - ViewModifier
struct InputBorderAndColorModifier: ViewModifier {
    @FocusState private var isFocused: Bool
    
    func body(content: Content) -> some View {
        content
            .focused($isFocused)
            .padding(8)
            .autocorrectionDisabled()
            .foregroundColor(
                isFocused ? .green : .primary
            )
            .animation(.easeInOut, value: isFocused)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(
                        isFocused ? Color.green : Color.gray,
                        lineWidth: 2
                    )
            )
    }
}

//MARK: - ButtonStyle
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
 
