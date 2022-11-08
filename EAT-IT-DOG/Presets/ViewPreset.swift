/// View Preset
/// Created by Mercen on 2022/09/29.

import SwiftUI

// MARK: - Color Extension
extension Color {
    static let basics = Color("Basics")
    static let general = Color("General")
    static let soft = Color("Soft")
    static let background = Color("Background")
    static let yellow = Color("Yellow")
    static let green = Color("Green")
}


func colorLoop(_ list: [String], _ key: String) -> Color {
    switch(list.firstIndex(where: { $0 == key })! % 3) {
    case 0: return .green
    case 1: return .yellow
    default: return .accentColor
    }
}

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        (UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets ?? .zero).insets
    }
}

extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

private extension UIEdgeInsets {
    var insets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}

enum Alignments {
    case top
    case bottom
    case leading
    case trailing
}

// MARK: - View Extension
extension View {
    
    @ViewBuilder func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition { transform(self) }
        else { self }
    }
    
    @ViewBuilder func roundedCorner(_ radius: CGFloat) -> some View {
        self
            .clipShape(RoundedRectangle(cornerRadius: radius))
    }
    
    @ViewBuilder func customBackground() -> some View {
        ZStack {
            Color.background.ignoresSafeArea()
            self
        }
    }
    
    @ViewBuilder func setAlignment(_ alignment: Alignments) -> some View {
        switch alignment {
        case .top: VStack {
            self
            Spacer()
        }
        case .bottom: VStack {
            Spacer()
            self
        }
        case .leading: HStack {
            self
            Spacer()
        }
        case .trailing: HStack {
            Spacer()
            self
        }
        }
    }
    
    func placeholder<Content: View>(
       when shouldShow: Bool,
       alignment: Alignment = .leading,
       @ViewBuilder placeholder: () -> Content) -> some View {
           ZStack(alignment: alignment) {
               placeholder().opacity(shouldShow ? 1 : 0)
               self
       }
   }
    
    func placeholder(_ text: String, when shouldShow: Bool, alignment: Alignment = .leading) -> some View {
        placeholder(when: shouldShow, alignment: alignment) { Text(text).foregroundColor(.general) }
    }
    
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
    
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(DeviceShakeViewModifier(action: action))
    }
    
}

// MARK: - Transition Extension
extension AnyTransition {
    static var backslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading))
    }
}

// MARK: - Button Style
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

public func touch() {
    HapticManager.instance.impact(style: .light)
}
