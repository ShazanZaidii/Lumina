import SwiftUI

struct AppTheme {
    let isDark: Bool

    // MARK: - Calm theme (used by HomeView and others)
    // Solid background (not gradient) for a restrained look
    var background: Color {
        isDark ? Color(red: 0.05, green: 0.05, blue: 0.06) : Color(red: 0.98, green: 0.98, blue: 0.99)
    }

    // Surface (cards / central circle fill)
    var surface: Color {
        isDark ? Color(red: 0.10, green: 0.11, blue: 0.12) : .white
    }

    // Text
    var textPrimary: Color { isDark ? .white : .black }
    var textSecondary: Color { isDark ? Color.white.opacity(0.75) : Color.black.opacity(0.7) }

    // Single accent color (Spotify-like green for dark, YouTube Music-like red for light)
    var accent: Color {
        isDark
        ? Color(red: 0.29, green: 0.78, blue: 0.42)
        : Color(red: 0.88, green: 0.06, blue: 0.09)
    }

    // Subtle strokes/dividers
    var stroke: Color {
        isDark ? Color.white.opacity(0.08) : Color.black.opacity(0.08)
    }

    // Progress ring width
    var ringWidth: CGFloat { isDark ? 10 : 12 }

    // Shadows for elevation
    var surfaceShadow: Color { isDark ? Color.black.opacity(0.5) : Color.black.opacity(0.12) }

    // Button fill (subtle gradient of the accent)
    var buttonFill: LinearGradient {
        LinearGradient(colors: [accent, accent.opacity(0.92)], startPoint: .top, endPoint: .bottom)
    }

    // MARK: - Legacy properties kept for other views (so nothing else breaks)
    // Previous gradient background (kept in case other screens still use it)
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

    var accentGradient: AngularGradient {
        AngularGradient(
            gradient: Gradient(colors: [
                Color(red: 0.98, green: 0.45, blue: 0.35),
                Color(red: 0.98, green: 0.75, blue: 0.20),
                Color(red: 0.40, green: 0.88, blue: 0.60),
                Color(red: 0.28, green: 0.67, blue: 0.97),
                Color(red: 0.71, green: 0.49, blue: 0.98),
                Color(red: 0.98, green: 0.45, blue: 0.35)
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
    // Keep this helper, but point it to the solid background for the new look
    func themedBackground(_ theme: AppTheme) -> some View {
        background(theme.background.ignoresSafeArea())
    }
}
