//
//  ButtonStyle.swift
//  Lumina
//
//  Created by Shazan Zaidi on 12/11/25.
//

import Foundation
import SwiftUI

struct GentlePressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}


struct ButtonView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    let title: String
    let action: () -> Void
    var body: some View {
        Button {
            viewModel.pause = true
            viewModel.controlsImageIndex = 1
            
            action()
        } label: {
            Text(title).font(.system(size: 24, weight: .heavy)).frame(width: 105, height: 48).foregroundStyle(viewModel.isDarkMode ? Color.black : Color.white).background(viewModel.isDarkMode ? Color.white : Color.black).clipShape(Capsule())
        }
        .buttonStyle(GentlePressStyle())
        
    }
}

