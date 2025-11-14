//
//  ContentViewModel.swift
//  Lumina
//
//  Created by Shazan Zaidi on 11/11/25.
//

import Foundation
import SwiftUI

class ContentViewModel: ObservableObject{
    //UserDefaults
    @AppStorage("username") var username: String = ""
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @AppStorage("hasEnteredApp") var hasEnteredApp: Bool = false
    

//    @Published var countdown = [240, 360, 540, 720]
    @Published var timeRemaining: Int?
    @Published var timeUp = false
    @Published var index = 0
    @Published var controlsImageNames: [String] = ["pause.fill", "play.fill"]
    @Published var controlsImageIndex: Int = 1
    @Published var pause = true
    
    
//    PercentFill Default
    @Published var percentFill: Double = 0.0

    
    //Timer Options
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
    
    @Published var showStats = true
    
    @Published var demo = 0.0
    

    
    func focus () {
        
    }
    
    var togglePadding: Int{
        if isDarkMode{
            return -25
        }
        else {return 35}
    }
    
    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
    
    
    var ringColor: Color {
        Color(white: 0.75)
    

    }
    
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = .currency
//        numberFormatter.currencySymbol = ""
        return numberFormatter
    }
    
    func computeUsername(){
        if hasEnteredApp && username.isEmpty{
            username = "Lumie"
        }
    }

}
