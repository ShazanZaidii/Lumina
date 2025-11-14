//
//  alarmIcon.swift
//  Lumina
//
//  Created by Shazan Zaidi on 13/11/25.
//

import SwiftUI

struct alarmEarLeft: View {
    var body: some View {
        Capsule()
            .trim(from: 0, to: 0.5)
            
            .frame(width: 55, height: 62.7)
            .rotationEffect(.degrees(135))
    }
}

struct alarmEarRight: View {
    var body: some View {
        Capsule()
            .trim(from: 0, to: 0.5)
            
            .frame(width: 55, height: 62.7)
            .rotationEffect(.degrees(-135))
    }
}

struct alarmLeftLeg: View {
    var body: some View {
        Rectangle()
            .frame(width: 50, height: 20)
            .cornerRadius(8)
            .rotationEffect(.degrees(-226.5))

    }
}

struct alarmRightLeg: View {
    var body: some View {
        Rectangle()
            .frame(width: 50, height: 20)
            .cornerRadius(8)
            .rotationEffect(.degrees(226.5))
    }
}
#Preview {
    alarmRightLeg()
    alarmLeftLeg()
}
// 1.14
