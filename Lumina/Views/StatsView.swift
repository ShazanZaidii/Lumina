//
//  StatsView.swift
//  Lumina
//
//  Created by Shazan Zaidi on 13/11/25.
//

import SwiftUI

struct StatsView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        NavigationStack {
            VStack{
                
            }.toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    HStack{
                        Button {
                            dismiss()
                        } label: {
                            HStack{
                                Image(systemName: "chevron.backward.circle.fill").resizable().scaledToFit().frame(width: 30, height: 35).opacity(0.7)
                                Text("Stats").font(.system(size: 37, weight: .light))
                            }
                        }.buttonStyle(GentlePressStyle())
                        
                    }
                }
            }
        }
    }
}

#Preview {
    StatsView().environmentObject(ContentViewModel())
}


//Text("Hi, \(viewModel.username)").font(.system(size: 37, weight: .semibold))
