//
//  ThemeToggleView.swift
//  Lumena
//
//  Created by Shazan Zaidi on 11/11/25.
//


import SwiftUI

struct ThemeToggleView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    @Namespace private var animation

    var body: some View {
        VStack(spacing: 10) {
            

            ZStack(alignment: viewModel.isDarkMode ? .trailing : .leading) {
                // Capsule background
                Capsule()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 120, height: 45)
                    .overlay {
                        Text(viewModel.isDarkMode ? "Dark" : "Light").padding(.leading, CGFloat(viewModel.togglePadding))
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(viewModel.isDarkMode ? .white : .black)
                            .animation(.easeInOut, value: viewModel.isDarkMode)
                    }

                // Rolling icon
                Group {
                    if viewModel.isDarkMode {
                        Image(systemName: "moon.circle.fill")
                            .resizable()
                            .foregroundStyle(.white)
                            
                            .matchedGeometryEffect(id: "icon", in: animation)
                            .frame(width: 40, height: 40)
                            .padding(3)
                            .rotationEffect(.degrees(360))
                    } else {
                        Image(systemName: "moon.circle.fill")
                            .resizable()
                            .foregroundStyle(.black)
                            .matchedGeometryEffect(id: "icon", in: animation)
                            .frame(width: 40, height: 40)
                            .padding(3)
                            .rotationEffect(.degrees(0))
                    }
                }
            }
            .padding(.top, 5)
            .onTapGesture {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                    viewModel.isDarkMode.toggle()
                }
            }
        }
    }
}

#Preview {
    ThemeToggleView().environmentObject(ContentViewModel())
}
