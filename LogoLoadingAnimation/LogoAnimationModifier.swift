//
//  LogoAnimationModifier.swift
//  LogoLoadingAnimation
//
//  Created by Васлий Николаев on 24.01.2022.
//

import SwiftUI

enum AnimatedFigures {
    case topLeftRectangle
    case topRightRectangle
    case bottomRightRectangle
    case bottomLeftRectangle
    case insideCircle
    case outsideCircle
}

struct CustomLogoAnimation: AnimatableModifier {
    var progress: CGFloat = 0

    var animatableData: CGFloat {
        get {
            progress
        }
        set {
            progress = newValue
        }
    }

    var figure: AnimatedFigures

    private var size: CGFloat {
        switch figure {
        case .topLeftRectangle:
            return 28.0
        case .topRightRectangle, .bottomLeftRectangle:
            return 24.0
        case .bottomRightRectangle:
            return 22.0
        case .insideCircle:
            return 1.0
        case .outsideCircle:
            return 80.0
        }
    }

    private var inProgressSize: CGFloat {
        switch figure {
        case .topLeftRectangle, .topRightRectangle, .bottomRightRectangle, .bottomLeftRectangle:
            return 16.0
        case .insideCircle:
            return 24.0
        case .outsideCircle:
            return 32.0
        }
    }

    private var offsetX: CGFloat {
        switch figure {
        case .topLeftRectangle:
            return -14.0
        case .topRightRectangle:
            return 14.0
        case .bottomRightRectangle:
            return 14.0
        case .bottomLeftRectangle:
            return -14.0
        case .insideCircle:
            return 0.0
        case .outsideCircle:
            return 0.0
        }
    }

    private var inProgressOffsetX: CGFloat {
        switch figure {
        case .topLeftRectangle:
            return -8.0
        case .topRightRectangle:
            return 8.0
        case .bottomRightRectangle:
            return 8.0
        case .bottomLeftRectangle:
            return -8.0
        case .insideCircle:
            return 0.0
        case .outsideCircle:
            return 0.0
        }
    }

    private var offsetY: CGFloat {
        switch figure {
        case .topLeftRectangle, .topRightRectangle:
            return -14.0
        case .bottomRightRectangle, .bottomLeftRectangle:
            return 14.0
        case .insideCircle, .outsideCircle:
            return 0.0
        }
    }

    private var inProgressOffsetY: CGFloat {
        switch figure {
        case .topLeftRectangle, .topRightRectangle:
            return -8.0
        case .bottomRightRectangle, .bottomLeftRectangle:
            return 8.0
        case .insideCircle, .outsideCircle:
            return 0.0
        }
    }

    func body(content: Content) -> some View {
        switch figure {
        case .topLeftRectangle, .topRightRectangle, .bottomRightRectangle, .bottomLeftRectangle:
            content
                .frame(size: linearAnimation(with: size, and: inProgressSize))
                .cornerRadius(linearAnimation(with: 6.0, and: 0.0))
                .offset(x: linearAnimation(with: offsetX, and: inProgressOffsetX))
                .offset(y: linearAnimation(with: offsetY, and: inProgressOffsetY))
        case .insideCircle:
            content
                .frame(size: linearAnimation(with: size, and: inProgressSize))
        case .outsideCircle:
            content
                .mask {
                    Circle()
                        .frame(size: linearAnimation(with: size, and: inProgressSize))
                }
        }
    }
}

private extension CustomLogoAnimation {
    func linearAnimation(with startValue: CGFloat, and endValue: CGFloat) -> CGFloat {
        var val = startValue
        if progress < 540 {
            val = endValue
        } else if progress >= 540, progress <= 630 {
            val = lineThroughTwoPoints(startValue: endValue, endValue: startValue, startDegrees: 540, endDegrees: 630)
        } else if progress >= 900 {
            val = lineThroughTwoPoints(startValue: startValue, endValue: endValue, startDegrees: 900, endDegrees: 990)
        }
        return val
    }

    func lineThroughTwoPoints(startValue: CGFloat, endValue: CGFloat, startDegrees: CGFloat, endDegrees: CGFloat) -> CGFloat {
        return (progress - endDegrees) * (startValue - endValue) / (startDegrees - endDegrees) + endValue
    }
}
