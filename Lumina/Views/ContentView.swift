//
//  ContentView.swift
//  Lumina
//
//  Created by Shazan Zaidi on 11/11/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var timeRemaining: Int = 240
    @State var percentFill = 0.0
    @Environment(\.dismiss) var dismiss
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
           //Toggle
            Group {
                ThemeToggleView()
                    .environmentObject(viewModel)
                    .offset(x: 120, y: -375)
            }.zIndex(1)
            
            Group{
                Circle().frame(width: 300, height: 300)
                Text("\(viewModel.formatTime(timeRemaining))").foregroundStyle(viewModel.isDarkMode ? Color.black : Color.white).font(.system(size: 50, weight: .bold, design: .default))
            }.overlay{
                ZStack{
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round)).frame(width: 335, height: 335)
                    Circle()
                        .trim(from: 0, to: CGFloat(percentFill))
                        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                        .fill(Color(red: viewModel.redValue, green: viewModel.greenValue, blue: viewModel.blueValue))
                        .frame(width: 320, height: 330).rotationEffect(.degrees(-90)).animation(.easeInOut(duration: 0.5), value: percentFill)
           
                        
                }
            }
        }
        .onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                    
                    
                }
                if timeRemaining == 0 {
                    viewModel.timeUp = true
                    
            
                }
            viewModel.timeRemaining = timeRemaining
            percentFill = 1.0 - Double(timeRemaining) / Double(viewModel.countdown[viewModel.index ])
            viewModel.computeColor(percentFill)

        }
        
        .onChange(of: viewModel.index) { oldValue, newValue in
            guard let index = viewModel.index as Int? else { return }
            timeRemaining = viewModel.countdown[index]

        }
//        .onChange(of: percentFill, { oldValue, newValue in
//
//        })
        .padding()
    }
}

#Preview {
    ContentView()
}
