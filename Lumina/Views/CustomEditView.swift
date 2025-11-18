//
//  CustomEditView.swift
//  Lumina
//
//  Created by Shazan Zaidi on 12/11/25.
//

import SwiftUI

struct CustomEditView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    @Environment(\.dismiss) var dismiss

    // Local hour/minute/second state for each section
    @State private var focusHours: Int = 0
    @State private var focusMinutes: Int = 25
    @State private var focusSeconds: Int = 0

    @State private var shortHours: Int = 0
    @State private var shortMinutes: Int = 5
    @State private var shortSeconds: Int = 0

    @State private var longHours: Int = 0
    @State private var longMinutes: Int = 30
    @State private var longSeconds: Int = 0

    // Ranges
    private let hourRange = Array(0...23)     // up to 24 hours
    private let minuteRange = Array(0...59)
    private let secondRange = Array(0...59)

    var body: some View {
        NavigationStack {
            Form {
                Section("Focus") {
                    timeWheel(hours: $focusHours, minutes: $focusMinutes, seconds: $focusSeconds)
                    HStack {
                        Spacer()
                        Text(viewModel.formatTimeHMS(focusHours * 3600 + focusMinutes * 60 + focusSeconds))
                            .foregroundStyle(.secondary)
                    }
                }

                Section("Short Break") {
                    timeWheel(hours: $shortHours, minutes: $shortMinutes, seconds: $shortSeconds)
                    HStack {
                        Spacer()
                        Text(viewModel.formatTimeHMS(shortHours * 3600 + shortMinutes * 60 + shortSeconds))
                            .foregroundStyle(.secondary)
                    }
                }

                Section("Long Break") {
                    timeWheel(hours: $longHours, minutes: $longMinutes, seconds: $longSeconds)
                    HStack {
                        Spacer()
                        Text(viewModel.formatTimeHMS(longHours * 3600 + longMinutes * 60 + longSeconds))
                            .foregroundStyle(.secondary)
                    }
                }

                Section {
                    Button {
                        // Write back totals in seconds
                        viewModel.focusCountdownUserInput = focusHours * 3600 + focusMinutes * 60 + focusSeconds
                        viewModel.shortCountdownUserInput = shortHours * 3600 + shortMinutes * 60 + shortSeconds
                        viewModel.longCountdownUserInput = longHours * 3600 + longMinutes * 60 + longSeconds

                        viewModel.focusCountdown[viewModel.focusCountdownIndex] = viewModel.focusCountdownUserInput
                        viewModel.shortCountdown[viewModel.shortCountdownIndex] = viewModel.shortCountdownUserInput
                        viewModel.longCountdown[viewModel.longCountdownIndex] = viewModel.longCountdownUserInput

                        
                    } label: {
                        Text("Save Changes")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(viewModel.isDarkMode ? Color.white : Color.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                    }
                    
                }
            }
            .navigationTitle("Edit Durations")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.pause = true
                        viewModel.controlsImageIndex = 1
                        viewModel.percentFill = 0
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                    }
                    .buttonStyle(.plain)
                }
            }
            .onAppear {
                // Seed wheels from current model values (seconds -> h/m/s)
                seed(&focusHours, &focusMinutes, &focusSeconds, from: viewModel.focusCountdownUserInput)
                seed(&shortHours, &shortMinutes, &shortSeconds, from: viewModel.shortCountdownUserInput)
                seed(&longHours, &longMinutes, &longSeconds, from: viewModel.longCountdownUserInput)
            }
        }
    }

    private func seed(_ h: inout Int, _ m: inout Int, _ s: inout Int, from total: Int) {
        let clamped = max(0, total)
        h = clamped / 3600
        m = (clamped % 3600) / 60
        s = clamped % 60
    }

    // MARK: - Subview
    @ViewBuilder
    private func timeWheel(hours: Binding<Int>, minutes: Binding<Int>, seconds: Binding<Int>) -> some View {
        HStack(spacing: 0) {
            Picker("Hours", selection: hours) {
                ForEach(hourRange, id: \.self) { h in
                    Text("\(h) hr").tag(h)
                }
            }
            .pickerStyle(.wheel)
            .frame(maxWidth: .infinity)
            .clipped()

            Picker("Minutes", selection: minutes) {
                ForEach(minuteRange, id: \.self) { m in
                    Text("\(m) min").tag(m)
                }
            }
            .pickerStyle(.wheel)
            .frame(maxWidth: .infinity)
            .clipped()

            Picker("Seconds", selection: seconds) {
                ForEach(secondRange, id: \.self) { s in
                    Text(String(format: "%02d sec", s)).tag(s)
                }
            }
            .pickerStyle(.wheel)
            .frame(maxWidth: .infinity)
            .clipped()
        }
        .frame(height: 160)
        .accessibilityElement(children: .contain)
    }
}

#Preview {
    CustomEditView().environmentObject(ContentViewModel())
}
