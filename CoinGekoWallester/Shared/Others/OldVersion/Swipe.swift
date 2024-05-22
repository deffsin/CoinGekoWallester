//
//  Swipe.swift
//  Wallester
//
//  Created by Denis Sinitsa on 20.05.2024.
//

// import SwiftUI

// struct Swipe<Content: View, Right1: View, Right2: View, Right3: View, Chart: View>: // View {
//     var content: () -> Content
//     var right1: () -> Right1
//     var right2: () -> Right2
//     var right3: () -> Right3
//     var chart: () -> Chart
//     var itemHeight: CGFloat
// 
//     @State var hoffset: CGFloat = 0
//     @State var anchor: CGFloat = 0
// 
//     let screenWidth = UIScreen.main.bounds.width
//     var buttonWidth: CGFloat { screenWidth / 6.5 }
//     var totalButtonWidth: CGFloat { buttonWidth * 3 }
//     var swipeThreshold: CGFloat { screenWidth / 15 }
//     var chartWidth: CGFloat = 110
// 
//     init(@ViewBuilder content: @escaping () -> Content,
//          @ViewBuilder right1: @escaping () -> Right1,
//          @ViewBuilder right2: @escaping () -> Right2,
//          @ViewBuilder right3: @escaping () -> Right3,
//          @ViewBuilder chart: @escaping () -> Chart,
//          itemHeight: CGFloat) {
// 
//         self.content = content
//         self.right1 = right1
//         self.right2 = right2
//         self.right3 = right3
//         self.chart = chart
//         self.itemHeight = itemHeight
// 
//         _hoffset = State(initialValue: 0)
//         _anchor = State(initialValue: 0)
//     }
// 
//     var drag: some Gesture {
//         DragGesture()
//             .onChanged { value in
//                 withAnimation {
//                     hoffset = min(0, anchor + value.translation.width)
//                 }
//             }
//             .onEnded { value in
//                 withAnimation {
//                     let chartThreshold = -(chartWidth + 10)
//                     let buttonThreshold = -(totalButtonWidth + chartWidth + 10)
// 
//                     if hoffset < buttonThreshold / 2 {
//                         anchor = buttonThreshold
//                     } else if hoffset < chartThreshold / 2 {
//                         anchor = chartThreshold
//                     } else {
//                         anchor = 0
//                     }
//                     hoffset = anchor
//                 }
//             }
//     }
// 
//     var body: some View {
//         GeometryReader { geo in
//             HStack(spacing: 0) {
//                 Spacer(minLength: 0)
// 
//                 content()
//                     .frame(width: geo.size.width)
//                     .zIndex(0)
// 
//                 chart()
//                     .frame(width: chartWidth)
//                     .zIndex(1)
//                     .padding(.trailing, 10)
//                     // .opacity(hoffset <= -chartWidth / 2 ? 1 : 0)
// 
//                 HStack(spacing: 0) {
//                     right1()
//                         .frame(width: buttonWidth)
//                         .zIndex(2)
//                     right2()
//                         .frame(width: buttonWidth)
//                         .zIndex(2)
//                     right3()
//                         .frame(width: buttonWidth)
//                         .zIndex(2)
//                 }
//                 .frame(width: totalButtonWidth)
//             }
//             .frame(height: itemHeight)
//         }
//         .offset(x: hoffset)
//         .frame(height: itemHeight)
//         .contentShape(Rectangle())
//         .gesture(drag)
//         .clipped()
//     }
// }
// 
