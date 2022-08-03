//
//  RotationEffect.swift
//  LogoLoadingAnimation
//
//  Created by Васлий Николаев on 09.02.2022.
//

import SwiftUI

extension View {
    func rotationAnimation(on value: CGFloat) -> some View {
        modifier(CustomRotationModifier(progress: value))
    }
}

struct CustomRotationModifier: AnimatableModifier {

    var progress: CGFloat = 0

    var animatableData: CGFloat {
        get {
            progress
        }
        set {
            progress = newValue
        }
    }

    func body(content: Content) -> some View {
        content
            .rotationEffect(progress <= 630 ? Angle(degrees: progress + 90) : progress > 900 ? Angle(degrees: progress - 900) : .zero)
    }
}
