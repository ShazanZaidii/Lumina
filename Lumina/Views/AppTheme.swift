import SwiftUI

struct AppTheme {
    let isDark: Bool

    // Base colors
    var bgGradient: LinearGradient {
        if isDark {
            return LinearGradient(
                colors: [
                    Color(red: 0.08, green: 0.08, blue: 0.12),
                    Color(red: 0.07, green: 0.10, blue: 0.18),
                    Color(red: 0.05, green: 0.12, blue: 0.22)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        } else {
            return LinearGradient(
                colors: [
                    Color(red: 0.96, green: 0.97, blue: 1.00),
                    Color(red: 0.90, green: 0.95, blue: 1.00),
                    Color(red: 0.86, green: 0.93, blue: 0.98)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }

    var cardFill: Color {
        isDark ? Color.white.opacity(0.06) : Color.white.opacity(0.65)
    }

    var textPrimary: Color {
        isDark ? Color.white : Color.black
    }

    var textSecondary: Color {
        isDark ? Color.white.opacity(0.75) : Color.black.opacity(0.7)
    }

    var accentGradient: AngularGradient {
        AngularGradient(
            gradient: Gradient(colors: [
                Color(red: 0.98, green: 0.45, blue: 0.35), // Coral
                Color(red: 0.98, green: 0.75, blue: 0.20), // Amber
                Color(red: 0.40, green: 0.88, blue: 0.60), // Mint
                Color(red: 0.28, green: 0.67, blue: 0.97), // Blue
                Color(red: 0.71, green: 0.49, blue: 0.98), // Purple
                Color(red: 0.98, green: 0.45, blue: 0.35)  // Back to Coral for smooth loop
            ]),
            center: .center
        )
    }

    var accentStrokeColor: Color {
        isDark ? Color.white.opacity(0.15) : Color.black.opacity(0.08)
    }

    var buttonGradient: LinearGradient {
        if isDark {
            return LinearGradient(
                colors: [
                    Color(red: 0.98, green: 0.45, blue: 0.35),
                    Color(red: 0.71, green: 0.49, blue: 0.98)
                ],
                startPoint: .leading,
                endPoint: .trailing
            )
        } else {
            return LinearGradient(
                colors: [
                    Color(red: 0.28, green: 0.67, blue: 0.97),
                    Color(red: 0.40, green: 0.88, blue: 0.60)
                ],
                startPoint: .leading,
                endPoint: .trailing
            )
        }
    }

    var toggleTrack: LinearGradient {
        if isDark {
            return LinearGradient(
                colors: [Color.white.opacity(0.10), Color.white.opacity(0.06)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        } else {
            return LinearGradient(
                colors: [Color.black.opacity(0.08), Color.black.opacity(0.04)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }

    var chartFocus: Color {
        isDark ? Color(red: 0.28, green: 0.67, blue: 0.97) : Color(red: 0.18, green: 0.45, blue: 0.85)
    }

    var chartBreak: Color {
        isDark ? Color(red: 0.98, green: 0.75, blue: 0.20) : Color(red: 0.98, green: 0.60, blue: 0.15)
    }
}

extension View {
    func themedBackground(_ theme: AppTheme) -> some View {
        self.background(theme.bgGradient.ignoresSafeArea())
    }
}
