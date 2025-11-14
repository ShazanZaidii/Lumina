
//
//  EntryView.swift
//  Lumina
//
//  Created by Shazan Zaidi on 11/11/25.
//

import SwiftUI

struct EntryView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var navigateToMain = false
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    Text("Master your minutes to \t\t master your life \t \t").font(.system(size: 35, weight: .medium, design: .default)).padding(.horizontal, 20).padding(.top, 50)
                    
                    Spacer()
                    
                    Image("entryImage1")
                        .resizable().scaledToFit().frame(width: 300, height: 300).clipShape(RoundedRectangle(cornerRadius: 18))
                        .padding(.top, -150)/*.saturation(0)*/
                    Spacer()
                    
                    //Enter Button
                    Button {
                        viewModel.hasEnteredApp = true
                        navigateToMain = true
                        viewModel.computeUsername()
                    } label: {
                        Text("Enter")
                            .font(.system(size: 27, weight: .heavy))
                            .frame(width: 300, height: 50)
                            .foregroundStyle(.white)
                            .background(Color.purple)
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                    }
                    .buttonStyle(.plain)
                    
                    
                    .padding(.top, -150)
                }
                
                TextField(text: $viewModel.username) {
                    Text("What Should I Call You? (Optional)")
                }.padding().frame(width: 347, height: 20)
                    .font(.system(size: 20, weight: .semibold)).padding(.vertical).overlay{
                    RoundedRectangle(cornerRadius: 5).fill(.clear).stroke(Color.gray, lineWidth: 1)}
                    
                    .padding(.top, 400)
            }
            .navigationDestination(isPresented: $navigateToMain) {
                HomeView()
                    .environmentObject(viewModel)
                    .navigationBarBackButtonHidden(true)
            }
            
            
        }

    }
}

#Preview {
    EntryView()
}



