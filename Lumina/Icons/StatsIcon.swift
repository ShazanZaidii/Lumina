//
//  StatsView.swift
//  Lumina
//
//  Created by Shazan Zaidi on 12/11/25.
//

import SwiftUI

struct StatsIcon: View {

    var body: some View {
        ZStack {
            Circle().frame(width: 53, height: 53).foregroundColor(Color.gray).opacity(0.2).offset(y:-10)
            HStack {
                Rectangle().frame(width: 7.5, height: 10)
                Rectangle().frame(width: 7.5, height: 15).offset(y: -2.5).padding(.leading, -5)
                Rectangle().frame(width: 7.5, height: 25).offset(y: -7.5).padding(.leading, -5)
            }.overlay {
                
                Image(systemName: "line.diagonal")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .font(.system(size: 7.5, weight: .light))
                    .rotationEffect(Angle(degrees: 3))
                    .offset(x: -2.5, y: -17)
                
                Image(systemName: "greaterthan")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 7.5, height: 25)
                    .font(.system(size: 7.5, weight: .medium))
                    .rotationEffect(Angle(degrees: -35.5))
                    .offset(x: 8.75, y: -27.25)
            }
        }

    }
}

#Preview {
    StatsIcon()
}
