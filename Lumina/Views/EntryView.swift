
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
                    Text("Master your minutes to \t\t master your life \t \t").font(.system(size: 35, weight: .medium, design: .default)).padding(.horizontal, 20).padding(.top, 60)
                    
                    Spacer()
                    
                    Image("entryImage1")
                        .resizable().scaledToFit().frame(width: 300, height: 300).clipShape(RoundedRectangle(cornerRadius: 18))
                        .padding(.top, -150)/*.saturation(0)*/
                    Spacer()
                    
                    //Enter Button
                    Button {
                        viewModel.hasEnteredApp = true
                        navigateToMain = true
                        
                    } label: {
                        Text("Enter")
                            .font(.system(size: 27, weight: .heavy))
                            .frame(width: 300, height: 50)
                            .foregroundStyle(.white)
                            .background(Color.purple)
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                    }
                    .buttonStyle(GentlePressStyle())
                    .padding(.top, -165)
                }
                

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



