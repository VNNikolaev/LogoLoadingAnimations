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

    var size: CGFloat {
        switch figure {
        case .topLeftRectangle:
            return 28.0
        case .topRightRectangle:
            return 24.0
        case .bottomRightRectangle:
            return 22.0
        case .bottomLeftRectangle:
            return 24.0
        case .insideCircle:
            return 80.0
        case .outsideCircle:
            return 1.0
        }
    }

    var offsetX: CGFloat {
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

    var offsetY: CGFloat {
        switch figure {
        case .topLeftRectangle:
            return -14.0
        case .topRightRectangle:
            return -14.0
        case .bottomRightRectangle:
            return 14.0
        case .bottomLeftRectangle:
            return 14.0
        case .insideCircle:
            return 0.0
        case .outsideCircle:
            return 0.0
        }
    }

    var cornerValue: CGFloat = 6.0

    var corner: UIRectCorner {
        switch figure {
        case .topLeftRectangle:
            return .topLeft
        case .topRightRectangle:
            return .topRight
        case .bottomRightRectangle:
            return .bottomRight
        case .bottomLeftRectangle:
            return .bottomLeft
        case .insideCircle:
            return .allCorners
        case .outsideCircle:
            return .allCorners
        }
    }

    var frame: CGFloat {
        var val: CGFloat = size
        if progress <= 90 {
            val = progress / 5.625 - progress * size / 90 + size
        } else if progress > 90 && progress < 630 {
            val = 16
        } else if progress >= 630 && progress <= 720 {
            val = (progress - 630) * (size - 16) / 90 + 16
        } else {
            val = size
        }
        return val
    }

    var outsideCircleFrame: CGFloat {
        var val = size

        if progress <= 90 {
            val = -8.0 / 15.0 * progress + 80.0
        } else if progress > 90 && progress < 630 {
            val = 32.0
        } else if progress >= 630 && progress <= 720 {
            val = 8.0 / 15.0 * progress - 304.0
        } else {
            val = size
        }
        return val
    }

    var insideCircleFrame: CGFloat {
        var val = size

        if progress <= 90 {
            val = progress / 3.75
        } else if progress > 90 && progress < 630 {
            val = 24
        } else if progress >= 630 && progress <= 720 {
            val = -4 / 15 * progress + 192
        } else {
            val = 1
        }
        return val
    }

    var x: CGFloat {
        var val: CGFloat = offsetX
        if progress <= 90 {
            switch figure {
            case .topLeftRectangle, .bottomLeftRectangle:
                val = progress * (-8 - offsetX) / 90 + offsetX
            case .topRightRectangle, .bottomRightRectangle:
                val = progress * (8 - offsetX) / 90 + offsetX
            case .insideCircle:
                break
            case .outsideCircle:
                break
            }
        } else if progress > 90 && progress < 630 {
            switch figure {
            case .topLeftRectangle, .bottomLeftRectangle:
                val = -8.0
            case .topRightRectangle, .bottomRightRectangle:
                val = 8.0
            case .insideCircle:
                break
            case .outsideCircle:
                break
            }
        } else if progress >= 630 && progress <= 720 {
            switch figure {
            case .topLeftRectangle, .bottomLeftRectangle:
                val = (progress - 630) * (offsetX + 8) / 90 - 8
            case .topRightRectangle, .bottomRightRectangle:
                val = (progress - 630) * (offsetX - 8) / 90 + 8
            case .insideCircle:
                break
            case .outsideCircle:
                break
            }
        } else {
            val = offsetX
        }
        return val
    }

    var y: CGFloat {
        var val: CGFloat = offsetY
        if progress <= 90 {
            switch figure {
            case .topLeftRectangle, .topRightRectangle:
                val = progress * (-8 - offsetY) / 90 + offsetY
            case .bottomRightRectangle, .bottomLeftRectangle:
                val = progress * (8 - offsetY) / 90 + offsetY
            case .insideCircle:
                break
            case .outsideCircle:
                break
            }
        } else if progress > 90 && progress < 630 {
            switch figure {
            case .topLeftRectangle, .topRightRectangle:
                val = -8.0
            case .bottomRightRectangle, .bottomLeftRectangle:
                val = 8.0
            case .insideCircle:
                break
            case .outsideCircle:
                break
            }
        } else if progress >= 630 && progress <= 720 {
            switch figure {
            case .topLeftRectangle, .topRightRectangle:
                val = (progress - 630) * (offsetY + 8) / 90 - 8
            case .bottomRightRectangle, .bottomLeftRectangle:
                val = (progress - 630) * (offsetY - 8) / 90 + 8
            case .insideCircle:
                break
            case .outsideCircle:
                break
            }
        } else {
            val = offsetY
        }
        return val
    }

    var cornerRadius: CGFloat {
        var val = cornerValue
        if progress <= 90 {
            val = -1.0 / 15.0 * progress + 6.0
        } else if progress > 90 && progress < 630 {
            val = 0.0
        } else if progress >= 630 && progress <= 720 {
            val = 1.0 / 15.0 * progress - 42.0
        } else {
            val = cornerValue
        }
        return val

    }

    func body(content: Content) -> some View {
        switch figure {
        case .topLeftRectangle, .topRightRectangle, .bottomRightRectangle, .bottomLeftRectangle:
            content
                .frame(width: frame, height: frame)
                .cornerRadius(cornerRadius)
                .offset(x: x, y: y)
        case .insideCircle:
            content
                .frame(width: insideCircleFrame, height: insideCircleFrame)
        case .outsideCircle:
            if #available(iOS 15.0, *) {
                content
                    .mask {
                        Circle()
                            .frame(width: outsideCircleFrame, height: outsideCircleFrame)
                    }
            }
        }
    }
}

