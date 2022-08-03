//
//  View+SizeExtension.swift
//  LogoLoadingAnimation
//
//  Created by Васлий Николаев on 03.08.2022.
//

import SwiftUI

extension View {
    @inlinable
    func frame(size: CGFloat, alignment: Alignment = .center) -> some View {
        frame(width: size, height: size, alignment: alignment)
    }
}
