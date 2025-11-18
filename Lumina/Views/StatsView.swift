//
//  StatsView.swift
//  Lumina
//
//  Created by Shazan Zaidi on 13/11/25.
//

import SwiftUI
import Charts   // REQUIRED for graphs

struct StatsView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    @Environment(\.dismiss) var dismiss

    // Convert dailyMinutes into graph data
    var weekData: [DayStat] {
        let last7 = (0..<7).reversed().map { offset -> DayStat in
            let date = Calendar.current.date(byAdding: .day, value: -offset, to: Date())!
            let key = viewModel.formattedDate(date)
            let minutes = viewModel.dailyMinutes[key, default: 0]
            return DayStat(date: date, minutes: minutes)
        }
        return last7
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack{
                    VStack(spacing: 25) {
                        
                        // OVERVIEW CARD
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(viewModel.isDarkMode ? 0.25 : 0.35))
                            .frame(height: 200)
                            .overlay(
                                VStack(spacing: 10) {
                                    Text("Overview")
                                        .font(.system(size: 26, weight: .semibold))
                                    
                                    Text(viewModel.hoursComputed == 0 ? "\(viewModel.totalMinutes) min"  : "\(viewModel.hoursComputed) hrs : \(viewModel.minutesComputed) min" )
                                        .font(.system(size: 44, weight: .bold))
                                    
                                    Text("\(viewModel.totalFocusSessions) focus · \(viewModel.totalBreakSessions) breaks")
                                        .font(.system(size: 18))
                                        .opacity(0.7)
                                }
                            )
                            .padding(.horizontal)
                        
                        // WEEKLY GRAPH
                        VStack(alignment: .leading) {
                            Text("Last 7 Days")
                                .font(.system(size: 22, weight: .semibold))
                                .padding(.leading)
                            
                            Chart(weekData) { stat in
                                BarMark(
                                    x: .value("Day", stat.date, unit: .day),
                                    y: .value("Minutes", stat.minutes)
                                )
                                .foregroundStyle(viewModel.isDarkMode ? .white : Color(white: 0.30).opacity(0.90) )
                            }
                            .frame(height: 200)
                            .padding(.horizontal)
                        }
                        
                        // PIE CHART LITE
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Session Types")
                                .font(.system(size: 22, weight: .semibold))
                                .padding(.leading)
                            
                            Chart {
                                SectorMark(
                                    angle: .value("Breaks", viewModel.totalBreakSessions),
                                    innerRadius: .ratio(0.55)
                                )
                                .foregroundStyle(viewModel.isDarkMode ? .gray : Color(white: 0.80).opacity(0.80))   // dark gray
                                
                                
                                SectorMark(
                                    angle: .value("Focus", viewModel.totalFocusSessions),
                                    innerRadius: .ratio(0.55)
                                )
                                .foregroundStyle(viewModel.isDarkMode ? .white : Color(white: 0.30).opacity(0.90) )
                            }
                            .frame(height: 220)
                            .padding(.horizontal)
                        }
                        
                        Spacer(minLength: 40)
                        
                        
                    }
                    
                    VStack{
                        
                        HStack{
                            Rectangle().frame(width:20, height: 20).foregroundStyle(viewModel.isDarkMode ? .white : Color(white: 0.30).opacity(0.90) )
                            Text("Focus")
                        }.padding(.leading, -6)
                        
                        HStack{
                            Rectangle().frame(width:20, height: 20).foregroundStyle(viewModel.isDarkMode ? .gray : Color(white: 0.80).opacity(0.80))
                            Text("Breaks")
                        }
                        
                    }.scaleEffect(0.75).padding(.top, 340).padding(.leading, -190)
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    
                        Button {
                            dismiss()
                        } label: {
                            HStack{
                               
                            Image(systemName: "chevron.backward.circle.fill").resizable().scaledToFit().frame(width: 30, height: 35)
                                .opacity(0.7)
//                                Text("Stats").font(.system(size: 34, weight: .bold))
                        }
                        
                        
                        
                    }.buttonStyle(GentlePressStyle())
                }
            }
        }.onAppear {
            viewModel.computeTimeSpent()
        }
    }
}

// Data model for chart
struct DayStat: Identifiable {
    let id = UUID()
    let date: Date
    let minutes: Int
}



#Preview {
    StatsView().environmentObject(ContentViewModel())
}


// Total time = total minutes/60 = 9.95= 9H:57 min

