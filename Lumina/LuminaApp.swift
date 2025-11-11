//
//  LuminaApp.swift
//  Lumina
//
//  Created by Shazan Zaidi on 12/11/25.
//

import SwiftUI

@main
struct LuminaApp: App {
    @StateObject private var viewModel = ContentViewModel()
    var body: some Scene {
        WindowGroup {
            if viewModel.hasEnteredApp{
                ContentView()
                                .preferredColorScheme(viewModel.isDarkMode ? .dark : .light)
            }
            else{
                EntryView()
                    .preferredColorScheme(.light)
            }
        }
    }
}
