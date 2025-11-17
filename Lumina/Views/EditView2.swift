//
//  EditView.swift
//  Lumina
//
//  Created by Shazan Zaidi on 12/11/25.
//

import SwiftUI

struct EditView2: View {
    @EnvironmentObject var viewModel: ContentViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        
        NavigationStack{
        VStack{
            
            HStack{
                VStack{
                    Text("Focus Mode:").font(.system(size: 18, weight: .semibold)).padding().padding(.top, 30)
                    Text("(Enter value in Seconds)").padding().padding(.top, -30)
                }
                VStack{
                    TextField("Enter Time In Seconds", value: $viewModel.focusCountdownUserInput , formatter: viewModel.numberFormatter).keyboardType(.numberPad).frame(width: 200, height: 30)
                        .onSubmit {
                            viewModel.focusCountdown[viewModel.focusCountdownIndex] = viewModel.focusCountdownUserInput
                        }
                        .overlay{
                        RoundedRectangle(cornerRadius: 5).fill(.clear).stroke(Color.gray, lineWidth: 1)
                    }.padding(.leading, 30)
                    Text("That is \(viewModel.formatTime(viewModel.focusCountdownUserInput))")
                }
                
            }
            HStack{
                VStack{
                    Text("Short Break:").font(.system(size: 18, weight: .semibold)).padding().padding(.top, 30)
                    Text("(Enter value in Seconds)").padding().padding(.top, -30)
                }
                
                VStack {
                    TextField("Enter Time In Seconds", value: $viewModel.shortCountdownUserInput , formatter: viewModel.numberFormatter).keyboardType(.numberPad).frame(width: 200, height: 30)
                        .onSubmit {
                            viewModel.shortCountdown[viewModel.shortCountdownIndex] = viewModel.shortCountdownUserInput
                        }
                        .overlay{
                        RoundedRectangle(cornerRadius: 5).fill(.clear).stroke(Color.gray, lineWidth: 1)
                    }.padding(.leading, 30)
                    Text("That is \(viewModel.formatTime(viewModel.shortCountdownUserInput))")
                }

                
            }
            
            HStack{
                VStack{
                    Text("Long Break:").font(.system(size: 18, weight: .semibold)).padding().padding(.top, 30)
                    Text("(Enter value in Seconds)").padding().padding(.top, -30)
                }
                
                VStack {
                    TextField("Enter Time In Seconds", value: $viewModel.longCountdownUserInput , formatter: viewModel.numberFormatter).keyboardType(.numberPad).frame(width: 200, height: 30)
                        .onSubmit {
                            viewModel.longCountdown[viewModel.longCountdownIndex] = viewModel.longCountdownUserInput
                        }
                        .overlay{
                        RoundedRectangle(cornerRadius: 5).fill(.clear).stroke(Color.gray, lineWidth: 1)
                    }.padding(.leading, 30)
                    
                    Text("That is \(viewModel.formatTime(viewModel.longCountdownUserInput))")
                }

                
            }
            
            Button {
                viewModel.focusCountdown[viewModel.focusCountdownIndex] = viewModel.focusCountdownUserInput
                viewModel.shortCountdown[viewModel.shortCountdownIndex] = viewModel.shortCountdownUserInput
                viewModel.longCountdown[viewModel.longCountdownIndex] = viewModel.longCountdownUserInput
                SoundManager.shared.playSound(name: "chaloo", type: "mp3")
            } label: {
                Text("Save Changes").font(.system(size: 27, weight: .semibold)).frame(width: 200, height: 50).background(Color.gray.opacity(0.2))
                    .foregroundStyle(viewModel.isDarkMode ? .white : .black)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
            }
            .buttonStyle(GentlePressStyle())
            .padding(.top, 20)

            Spacer()
            
            
        }
        .toolbar {
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
//                            Text("Edit")
//                                .font(.system(size: 37, weight: .light))
                        }
                        
                        
                    }.buttonStyle(GentlePressStyle())
                    
                    }
                
            }
        }
    }}
}

#Preview {
    EditView2().environmentObject(ContentViewModel())
}





//                Slider(value: $viewModel.demo, in: 0...1)
//                Text("Value: \(viewModel.demo)")


//Text("Edit")
//.font(.system(size: 37, weight: .semibold))
