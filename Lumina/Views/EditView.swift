//
//  EditView2.swift
//  Lumina
//
//  Created by Shazan Zaidi on 15/11/25.
//

import SwiftUI

struct EditView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    @Environment(\.dismiss) var dismiss
    @State var isOn: Bool = false
    // A simple set of common durations in seconds
    @State private var availableDurations: [Int] = [120, 300, 600, 900, 1200, 1500, 1800, 2100,2400, 2700,3000, 3300, 3600]
    // Local selection mirrors whichever mode is selected
    @State private var selectedDuration: Int = 1500
    
    var body: some View {
        NavigationStack{
        ZStack{
            Color.gray.opacity(0.2).ignoresSafeArea()
            VStack{
                VStack(spacing: 20){
                    Text("Choose a Timer Option to Modify:").frame(width: 300, height: 40).glassEffect()
                    HStack{
                        EditButtonView(title: "Focus") {
                            viewModel.focusonEditFocus = true
                            viewModel.focusonEditshort = false
                            viewModel.focusonEditLong = false
                            viewModel.computeFocus()
                            // Reflect current value into the picker selection
                            selectedDuration = viewModel.focusCountdownUserInput
                        }
                        EditButtonView(title: "break") {
                            viewModel.focusonEditFocus = false
                            viewModel.focusonEditshort = true
                            viewModel.focusonEditLong = false
                            viewModel.computeFocus()
                            selectedDuration = viewModel.shortCountdownUserInput
                        }
                        EditButtonView(title: "Break") {
                            viewModel.focusonEditFocus = false
                            viewModel.focusonEditshort = false
                            viewModel.focusonEditLong = true
                            viewModel.computeFocus()
                            selectedDuration = viewModel.longCountdownUserInput
                        }
                        
                    }
                    Text(viewModel.focusOn.isEmpty ? "Please Select an Option.." : "Selected: \(viewModel.focusOn)")
                    
                    // Replace WheelPickerStyle() with a real Picker using the wheel style
                    Picker("Duration", selection: $selectedDuration) {
                        ForEach(availableDurations, id: \.self) { seconds in
                            Text("\(viewModel.formatTime(seconds))").font(.system(size: 30))
                                .tag(seconds)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .scaleEffect(1.3)
                    .padding(.top, -20)
                    .frame(height: 350)
                    .onChange(of: selectedDuration) { _, newValue in
                        // Write back to the appropriate user input based on current selection
                        if viewModel.focusonEditFocus {
                            viewModel.focusCountdown[0] = newValue
                        } else if viewModel.focusonEditshort {
                            viewModel.shortCountdown[0] = newValue
                        } else if viewModel.focusonEditLong {
                            viewModel.longCountdown[0] = newValue
                        }
                    }
                    
                    Spacer()
                }.padding(10)
                    .onAppear {
                        // Initialize the picker selection to something sensible
                        if viewModel.focusonEditFocus {
                            selectedDuration = viewModel.focusCountdownUserInput
                        } else if viewModel.focusonEditshort {
                            selectedDuration = viewModel.shortCountdownUserInput
                        } else if viewModel.focusonEditLong {
                            selectedDuration = viewModel.longCountdownUserInput
                        } else {
                            // default to focus if nothing selected yet
                            selectedDuration = viewModel.focusCountdownUserInput
                        }
                    }
//                Button {
//                    EditView2()
//                        
//                } label: {
//                    Text("Want a Custom Timer?")
//                }
                Group{
                Button {
                    viewModel.showCustomEditView = true
                    
                } label: {
                    Text("Want a Custom Timer?")
                }
                .navigationDestination(isPresented: $viewModel.showCustomEditView) {
                    CustomEditView()
                        .navigationBarBackButtonHidden(true)
                        .environmentObject(viewModel)
                }
                }

                
            }.toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack{
                        Button {
                            viewModel.pause = true
                            viewModel.controlsImageIndex = 1
                            viewModel.percentFill = 0
                            dismiss()
                        } label: {
                            HStack {
                                Image(systemName: "chevron.backward.circle.fill").resizable().scaledToFit().frame(width: 30, height: 35)
                                    .opacity(0.7)
                            }
                            
                            
                        }.buttonStyle(GentlePressStyle())
                        
                    }
                    
                }
            }
        }
    }
}
}

#Preview {
    EditView().environmentObject(ContentViewModel())
}


struct EditButtonView: View {
    let title: String
    let action: () -> Void
    var body: some View {
        Button {
            action()
            
        } label: {
            Text(title).frame(width: 80, height: 40)
        }
        //        .glassEffect().shadow(radius: 4)
        .buttonStyle(.glass)
        
    }
}
