//
//  ContentViewModel.swift
//  Lumina
//
//  Created by Shazan Zaidi on 11/11/25.
//

import Foundation
import SwiftUI

class ContentViewModel: ObservableObject{
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @AppStorage("hasEnteredApp") var hasEnteredApp: Bool = false
    @Published var countdown = [240, 360, 540, 720]
    @Published var timeRemaining: Int?
    @Published var timeUp = false
    @Published var index = 0
    @Published var redValue = 0.2
    @Published var greenValue = 0.8
    @Published var blueValue = 0.3
    
    
    
    
//    var percentFill: Int{
//        guard let timeRemaining = timeRemaining else {return 0}
//        return (timeRemaining / countdown[0])
//    }
//

    func computeColor (_ percentFill: Double) -> Void{
        if percentFill < 0.25{
            redValue = 0.2
            greenValue = 0.8
            blueValue = 0.3
            
        }
        else if percentFill > 0.25 && percentFill < 0.5{
            redValue = 0.6
            greenValue = 0.8
            blueValue = 0.2
            
        }
        else if percentFill > 0.5 && percentFill < 0.75{
            redValue = 0.9
            greenValue = 0.75
            blueValue = 0.2
            
        }
        else if percentFill > 0.75 && percentFill <= 1.0{
            redValue = 0.95
            greenValue = 0.55
            blueValue = 0.15
            
        }
//        else if percentFill > 0.8 && percentFill <= 1.0 {
//            redValue = 1.0
//            greenValue = 0.40
//            blueValue = 0.12
//
//        }
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

}
