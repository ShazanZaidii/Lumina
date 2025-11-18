//
//  ContentView.swift
//  Lumina
//
//  Created by Shazan Zaidi on 11/11/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var timeRemaining: Int = 1500
    @Environment(\.dismiss) var dismiss
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var hasToggledPlayPauseOnce = false
    
    var body: some View {
        NavigationStack{
        ZStack {
            //Toggle
            Group {
                ThemeToggleView()
                    .environmentObject(viewModel)
                    .offset(x: 120, y: -375)
            }.zIndex(1)
            
            // Reactive Fill and timer
            Group{
                Circle().frame(width: 300, height: 300)
                Text(viewModel.formatTimeHMS(timeRemaining))
                    .foregroundStyle(viewModel.isDarkMode ? Color.black : Color.white)
                    .font(.system(size: 50, weight: .bold, design: .default))
            }.overlay {
                ZStack {
                    //Outer ring
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                        .frame(width: 325, height: 325)
                   //Reactive Fill
                    Circle()
                        .trim(from: 0, to: CGFloat(viewModel.percentFill))
                        .stroke(
                            viewModel.ringColor,
                            style: StrokeStyle(lineWidth: viewModel.isDarkMode ? 6 : 9, lineCap: .round, lineJoin: .round)
                        )
                        .frame(width: 320, height: 320)
                        .rotationEffect(.degrees(-90))
                        .scaleEffect(0.964)
                        .animation(.easeInOut(duration: 0.5), value: viewModel.percentFill)

                }
                .frame(width: 320, height: 320, alignment: .center)
            }

            //Focus/ Breaks
            VStack{
                //MARK: -4 Buttons (Top)
                HStack{
                    
                    ButtonView(title: "Focus"){
                        // Sound removed
                        viewModel.focusOnCountdown = true
                        viewModel.shortOnCountdown = false
                        viewModel.longOnCountdown = false
                        timeRemaining = viewModel.focusCountdown[viewModel.focusCountdownIndex]
                        viewModel.percentFill = 0
                    }
                    
                    ButtonView(title: "break"){
                        // Sound removed
                        viewModel.focusOnCountdown = false
                        viewModel.shortOnCountdown = true
                        viewModel.longOnCountdown = false
                        timeRemaining = viewModel.shortCountdown[viewModel.shortCountdownIndex]
                        viewModel.percentFill = 0
                    }
                    ButtonView(title: "BREAK"){
                        // Sound removed
                        viewModel.focusOnCountdown = false
                        viewModel.shortOnCountdown = false
                        viewModel.longOnCountdown = true
                        timeRemaining = viewModel.longCountdown[viewModel.longCountdownIndex]
                        viewModel.percentFill = 0
                    }
                    //MARK: - Pencil icon
                    Group{
                    Button {
                        viewModel.showEditView = true
                        // Sound stop removed
                    } label: {
                        Image(systemName: "pencil.circle.fill").resizable().scaledToFit().frame(width: 35, height: 35).foregroundColor(viewModel.isDarkMode ? Color.white : Color.black).offset(y: 2)
                    }
                    .buttonStyle(.plain)
                    .navigationDestination(isPresented: $viewModel.showEditView) {
                        EditView()
                            .navigationBarBackButtonHidden(true)
                            .environmentObject(viewModel)
                    }
                    }
                    
                }
                .padding(.top, 120)
                .environmentObject(viewModel)
                Spacer()
                
                // Bottom Controls
                HStack {
                    Group{
                        Button {
                            let wasPaused = viewModel.pause
                            
                            // Toggle pause state
                            viewModel.pause.toggle()
                            
                            // Update icon index (original behavior)
                            if viewModel.controlsImageIndex == 0 {
                                viewModel.controlsImageIndex = 1
                            }
                            else{
                                viewModel.controlsImageIndex = 0
                                // Sound stop removed
                            }
                            
                            // Interchanged sound behavior removed (no-op)
                            if wasPaused && !viewModel.pause {
                                // pause -> play: no sound
                            } else if !wasPaused && viewModel.pause {
                                // play -> pause: no sound
                                hasToggledPlayPauseOnce = true
                            }
                            
                        } label: {
                            Image(systemName: viewModel.controlsImageNames[viewModel.controlsImageIndex]).resizable().scaledToFit().frame(width: 50, height: 50).foregroundColor(viewModel.isDarkMode ? Color.white : Color.black)
                        }
                        .buttonStyle(GentlePressStyle())
                        
                    }.padding()
                    Group{
                        Button {
                            if viewModel.focusOnCountdown {
                                timeRemaining = viewModel.focusCountdown[viewModel.focusCountdownIndex]
                                
                            }
                            else if viewModel.shortOnCountdown {
                                timeRemaining = viewModel.shortCountdown[viewModel.shortCountdownIndex]
                            }
                            else {
                                timeRemaining = viewModel.longCountdown[viewModel.longCountdownIndex]
                            }
                            viewModel.pause = true
                            // Sound removed
                            viewModel.controlsImageIndex = 1
                            viewModel.percentFill = 0
                            
                        } label: {
                            Image(systemName: "arrow.trianglehead.2.counterclockwise").resizable().scaledToFit().frame(width: 50, height: 50).foregroundColor(viewModel.isDarkMode ? Color.white : Color.black).font(.system(size: 30, weight: .bold))
                        }
                        
                    }
                }.offset(x:0 , y: -70)
            }

            //MARK: - Stats Icon (Top)
            Group {
                Button {
                    viewModel.showStats = true
                    // Removed viewModel.playSound side effects (kept method as no-op)
                    viewModel.playSound()
                } label: {
                    VStack {
                        HStack {
                            StatsIcon()
                                .environmentObject(viewModel)
                                .frame(width: 20, height: 20)
                            Spacer()
                        }
                        .padding(.leading, 20)
                        Spacer()
                    }
                }
                .buttonStyle(.plain)
                .navigationDestination(isPresented: $viewModel.showStats) {
                    StatsView()
                        .navigationBarBackButtonHidden(true)
                        .environmentObject(viewModel)
                }
            }
            
           

        }
        .onReceive(timer) { _ in
            if !viewModel.pause {
                if !viewModel.shortOnCountdown && !viewModel.longOnCountdown{
                    viewModel.focusOnCountdown = true
                }
                
                if timeRemaining > 0 {
                    timeRemaining -= 1
                }
                if timeRemaining == 0 {
                    viewModel.timeUp = true
                    viewModel.pause = true
                    viewModel.controlsImageIndex = 1
                    viewModel.recordSession()
                }

                viewModel.timeRemaining = timeRemaining
                if viewModel.focusOnCountdown{
                    viewModel.percentFill = 1.0 - Double(timeRemaining) / Double(viewModel.focusCountdown[viewModel.focusCountdownIndex ])
                }
                else if viewModel.shortOnCountdown{
                    viewModel.percentFill = 1.0 - Double(timeRemaining) / Double(viewModel.shortCountdown[viewModel.shortCountdownIndex ])
                    
                }
                else if viewModel.longOnCountdown{
                    viewModel.percentFill = 1.0 - Double(timeRemaining) / Double(viewModel.longCountdown[viewModel.longCountdownIndex ])
                }
            }
        }
        .padding()
        }
}
}

#Preview {
    HomeView()
}

