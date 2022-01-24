//
//  ContentView.swift
//  LogoLoadingAnimation
//
//  Created by Васлий Николаев on 24.01.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var progress = 0.0

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray)
                .ignoresSafeArea()
            //  Logo from rectangle
            VStack {
                ZStack {
                    // Left top rectangle
                    Rectangle()
                        .modifier(CustomLogoAnimation(progress: progress, figure: .topLeftRectangle))
                        .foregroundColor(.mint)
                    //  Right top rectangle
                    Rectangle()
                        .modifier(CustomLogoAnimation(progress: progress, figure: .topRightRectangle))
                        .foregroundColor(.white)
                    //  Right bottom rectangle
                    Rectangle()
                        .modifier(CustomLogoAnimation(progress: progress, figure: .bottomRightRectangle))
                        .foregroundColor(.white)
                    //  Left bottom rectangle
                    Rectangle()
                        .modifier(CustomLogoAnimation(progress: progress, figure: .bottomLeftRectangle))
                        .foregroundColor(.white)
                    //  Inside circle
                    Circle()
                        .modifier(CustomLogoAnimation(progress: progress, figure: .insideCircle))
                        .blendMode(.destinationOut)
                }
                //  Outside circle
                .modifier(CustomLogoAnimation(progress: progress, figure: .outsideCircle))
                .compositingGroup()
                .frame(width: 56.0, height: 56.0)
                .rotationEffect(.degrees(progress))
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 5).delay(1).repeatForever(autoreverses: false)) {
                    progress = 720
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
