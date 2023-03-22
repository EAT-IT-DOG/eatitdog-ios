//
//  ViewExt.swift
//  eatitdog
//
//  Created by Mercen on 2023/03/14.
//

import SwiftUI

// MARK: - View Extension
extension View {
    
//    let message: String
//    let buttonMessage: String
//    @Binding var isPresented: Bool
//    var cancelButton: Bool = false
//    let action: () -> Void
//    let content: Content
    
    @ViewBuilder func alertSheet(_ message: String,
                                 _ buttonMessage: String,
                                 isPresented: Binding<Bool>,
                                 action: @escaping () -> Void,
                                 cancelButton: Bool) -> some View {
        AlertSheet(message, buttonMessage, isPresented: isPresented, action: action, cancelButton: cancelButton) {
            self
        }
    }
    
    @ViewBuilder func setFont(_ size: CGFloat, _ weight: Font.Weight = .regular) -> some View {
        self
            .font(.system(size: size, weight: weight))
    }
    
    @ViewBuilder func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition { transform(self) }
        else { self }
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
