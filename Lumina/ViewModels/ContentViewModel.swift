//
//  ContentViewModel.swift
//  Lumina
//
//  Created by Shazan Zaidi on 11/11/25.
//

import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    

    //MARK: - ShowStats:
    @Published var showStats: Bool = false
    @Published var showEditView: Bool = false
    @Published var showCustomEditView: Bool = false   // Added for CustomEditView presentation
    
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
    @Published var focusCountdown: [Int] = [1500, 2700, 3600]
    @Published var focusCountdownIndex: Int = 0
    @Published var focusOnCountdown = false
    @Published var focusCountdownUserInput = 1500

    @Published var shortCountdown: [Int] = [300]
    @Published var shortCountdownIndex: Int = 0
    @Published var shortOnCountdown = false
    @Published var shortCountdownUserInput = 300

    @Published var longCountdown: [Int] = [1800]
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
    
    //MARK: - CustomEditView
    @Published var focusonEditFocus: Bool = false
    @Published var focusonEditshort: Bool = false
    @Published var focusonEditLong: Bool = false
    @Published var focusOn: String = ""
    
    func computeFocus(){
        if focusonEditFocus{
            focusOn = "Focus"
        }
        if focusonEditshort{
            focusOn = "break"
        }
        if focusonEditLong{
            focusOn = "Break"
        }
    }

    // MARK: - Init
    init() {
        loadDailyMinutes()
        // Derive totalMinutes from persisted dailyMinutes to avoid drift (no mock data).
        totalMinutes = dailyMinutes.values.reduce(0, +)
        // Do not seed random totals or daily entries.
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

        let minutes = sessionMinutes()
        totalMinutes += minutes

        dailyMinutes[today, default: 0] += minutes
        saveDailyMinutes()

        if focusOnCountdown {
            totalFocusSessions += 1
        } else {
            totalBreakSessions += 1
        }
    }

    func sessionMinutes() -> Int {
        if focusOnCountdown {
            return max(1, focusCountdown[focusCountdownIndex] / 60)
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
    
    func formatTimeHMS(_ totalSeconds: Int) -> String {
        let seconds = max(0, totalSeconds)
        let h = seconds / 3600
        let m = (seconds % 3600) / 60
        let s = seconds % 60
        if h > 0 {
            return String(format: "%d:%02d:%02d", h, m, s)
        } else {
            return String(format: "%02d:%02d", m, s)
        }
    }

    // MARK: - Ring
    var ringColor: Color {
        Color(white: 0.75)
    }

    var numberFormatter: NumberFormatter {
        NumberFormatter()
    }

    // Debug helper
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
    
    //MARK: - Sounds removed (no-ops kept if needed)
    func playSound() {
        // Intentionally left blank to preserve call sites if any remain.
    }
    
    @Published var hoursComputed: Int = 0
    @Published var minutesComputed: Int = 0
    func computeTimeSpent(){
        if totalMinutes >= 60 {
            hoursComputed = totalMinutes/60
            minutesComputed = totalMinutes%60
        } else {
            hoursComputed = 0
            minutesComputed = totalMinutes
        }
    }
}
