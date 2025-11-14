//
//  ContentViewModel.swift
//  Lumina
//
//  Created by Shazan Zaidi on 11/11/25.
//


//import Foundation
//import SwiftUI
//
//class ContentViewModel: ObservableObject{
//    //UserDefaults
//    @AppStorage("isDarkMode") var isDarkMode: Bool = false
//    @AppStorage("hasEnteredApp") var hasEnteredApp: Bool = false
//    
//
////    @Published var countdown = [240, 360, 540, 720]
//    @Published var timeRemaining: Int?
//    @Published var timeUp = false
//    @Published var index = 0
//    @Published var controlsImageNames: [String] = ["pause.fill", "play.fill"]
//    @Published var controlsImageIndex: Int = 1
//    @Published var pause = true
//    
//    
////    PercentFill Default
//    @Published var percentFill: Double = 0.0
//
//    
//    //Timer Options
//    @Published var focusCountdown: [Int] = [1500, 2700, 3600]
//    @Published var focusCountdownIndex: Int = 0
//    @Published var focusOnCountdown = false
//    @Published var focusCountdownUserInput = 1500
//    
//    @Published var shortCountdown: [Int] = [300]
//    @Published var shortCountdownIndex: Int = 0
//    @Published var shortOnCountdown = false
//    @Published var shortCountdownUserInput = 300
//    
//    @Published var longCountdown: [Int] = [1800]
//    @Published var longCountdownIndex: Int = 0
//    @Published var longOnCountdown = false
//    @Published var longCountdownUserInput = 1800
//    
//    @Published var showStats = true
//    
//    
//
//    
//    func focus () {
//        
//    }
//    
//    var togglePadding: Int{
//        if isDarkMode{
//            return -25
//        }
//        else {return 35}
//    }
//    
//    func formatTime(_ seconds: Int) -> String {
//        let minutes = seconds / 60
//        let remainingSeconds = seconds % 60
//        return String(format: "%02d:%02d", minutes, remainingSeconds)
//    }
//    
//    
//    var ringColor: Color {
//        Color(white: 0.75)
//    
//
//    }
//    
//    var numberFormatter: NumberFormatter {
//        let numberFormatter = NumberFormatter()
////        numberFormatter.numberStyle = .currency
////        numberFormatter.currencySymbol = ""
//        return numberFormatter
//    }
//    
//
//
//}


import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {

    // MARK: - App Settings
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @AppStorage("hasEnteredApp") var hasEnteredApp: Bool = false

    // MARK: - Timer Runtime
    @Published var timeRemaining: Int?
    @Published var timeUp = false
    @Published var pause = true
    @Published var percentFill: Double = 0.0
    @Published var controlsImageNames: [String] = ["pause.fill", "play.fill"]
    @Published var controlsImageIndex: Int = 1

    // MARK: - Modes
    @Published var focusCountdown: [Int] = [60, 1500, 2700, 3600]
    @Published var focusCountdownIndex: Int = 0
    @Published var focusOnCountdown = false
    @Published var focusCountdownUserInput = 1500

    @Published var shortCountdown: [Int] = [60, 300]
    @Published var shortCountdownIndex: Int = 0
    @Published var shortOnCountdown = false
    @Published var shortCountdownUserInput = 300

    @Published var longCountdown: [Int] = [60, 1800]
    @Published var longCountdownIndex: Int = 0
    @Published var longOnCountdown = false
    @Published var longCountdownUserInput = 1800

    // MARK: - Stats (Persistent)
    @AppStorage("totalFocusSessions") var totalFocusSessions: Int = 0
    @AppStorage("totalBreakSessions") var totalBreakSessions: Int = 0
    @AppStorage("totalMinutes") var totalMinutes: Int = 0

    // Persisting daily stats as a JSON-encoded Data blob in AppStorage
    // Stored key: "dailyMinutes"
    @AppStorage("dailyMinutes") private var dailyMinutesData: Data = Data()
    @Published var dailyMinutes: [String: Int] = [:]    // in-memory representation
    

    // MARK: - Init
    init() {
        loadDailyMinutes()
    }

    // MARK: - Helpers
    func formattedDate(_ date: Date = Date()) -> String {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        return f.string(from: date)
    }

    // Convert dictionary <-> Data for AppStorage
    private func loadDailyMinutes() {
        guard !dailyMinutesData.isEmpty else {
            dailyMinutes = [:]
            return
        }
        if let dict = try? JSONDecoder().decode([String:Int].self, from: dailyMinutesData) {
            self.dailyMinutes = dict
        } else {
            // fallback: reset to empty if decoding fails
            dailyMinutes = [:]
            dailyMinutesData = Data()
        }
    }

    private func saveDailyMinutes() {
        if let encoded = try? JSONEncoder().encode(dailyMinutes) {
            dailyMinutesData = encoded
        }
    }

    // MARK: - Stats Update
    func recordSession() {
        let today = formattedDate()

        // Update total minutes using sessionMinutes()
        let minutes = sessionMinutes()
        totalMinutes += minutes

        // Daily minutes
        dailyMinutes[today, default: 0] += minutes
        saveDailyMinutes()

        // Sessions count
        if focusOnCountdown {
            totalFocusSessions += 1
        } else {
            totalBreakSessions += 1
        }
    }

    func sessionMinutes() -> Int {
        if focusOnCountdown {
            return max(1, focusCountdown[focusCountdownIndex] / 60) // ensure at least 1 minute
        }
        if shortOnCountdown {
            return max(1, shortCountdown[shortCountdownIndex] / 60)
        }
        return max(1, longCountdown[longCountdownIndex] / 60)
    }

    // MARK: - Formatting
    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }

    // MARK: - Ring
    var ringColor: Color {
        Color(white: 0.75)
    }

    var numberFormatter: NumberFormatter {
        NumberFormatter()
    }

    // Debug helper (optional): clear stored daily data — use while developing
    func debugClearDailyData() {
        dailyMinutes = [:]
        dailyMinutesData = Data()
        totalMinutes = 0
        totalFocusSessions = 0
        totalBreakSessions = 0
    }
    
    var togglePadding: Int{
         if isDarkMode{
             return -25
         }
         else {return 35}
     }
}


