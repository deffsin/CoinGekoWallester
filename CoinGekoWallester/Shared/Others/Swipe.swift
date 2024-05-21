//
//  Swipe.swift
//  Wallester
//
//  Created by Denis Sinitsa on 20.05.2024.
//

import SwiftUI

struct Swipe<Content: View, Right1: View, Right2: View, Right3: View>: View {
    var content: () -> Content
    var right1: () -> Right1
    var right2: () -> Right2
    var right3: () -> Right3
    var itemHeight: CGFloat
    
    @State private var hoffset: CGFloat = 0
    @State private var anchor: CGFloat = 0
    
    private let screenWidth = UIScreen.main.bounds.width
    private var buttonWidth: CGFloat { screenWidth / 6.7 }
    private var totalButtonWidth: CGFloat { buttonWidth * 3 }
    private var swipeThreshold: CGFloat { screenWidth / 15 }
    
    @State private var rightPast = false
    
    init(@ViewBuilder content: @escaping () -> Content,
         @ViewBuilder right1: @escaping () -> Right1,
         @ViewBuilder right2: @escaping () -> Right2,
         @ViewBuilder right3: @escaping () -> Right3,
         itemHeight: CGFloat) {
        self.content = content
        self.right1 = right1
        self.right2 = right2
        self.right3 = right3
        self.itemHeight = itemHeight
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                withAnimation {
                    hoffset = min(0, anchor + value.translation.width)
                }
            }
            .onEnded { value in
                withAnimation {
                    if hoffset < -totalButtonWidth / 2 {
                        anchor = -totalButtonWidth
                    } else {
                        anchor = 0
                    }
                    
                    hoffset = anchor
                }
            }
    }

    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 0) {
                Spacer(minLength: 0)
                
                content()
                    .frame(width: geo.size.width)
                    .zIndex(0)
                
                HStack(spacing: 0) {
                    right1()
                        .frame(width: buttonWidth)
                        .zIndex(1)
                        .clipped()
                    
                    right2()
                        .frame(width: buttonWidth)
                        .zIndex(1)
                        .clipped()
                    
                    right3()
                        .frame(width: buttonWidth)
                        .zIndex(1)
                        .clipped()
                }
                .frame(width: totalButtonWidth)
            }
            .frame(height: 40)
        }
        .offset(x: hoffset)
        .frame(height: itemHeight)
        .contentShape(Rectangle())
        .gesture(drag)
        .clipped()
    }
}
