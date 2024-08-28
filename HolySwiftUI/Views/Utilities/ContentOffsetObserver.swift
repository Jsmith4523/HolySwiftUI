//
//  ContentOffsetObserver.swift
//  HolySwiftUI
//
//  Created by Jaylen Smith on 8/28/24.
//

import Foundation
import SwiftUI

extension View {
    
    func contentOffsetObserver() -> some View {
        return self
            .id("topOfContentView")
            .background {
                GeometryReader { geometry in
                    Color.clear.preference(key: ContentOffsetObserverPreferenceKey.self, value: geometry.frame(in: .named("scrollView")).minY)
                }
            }
    }
    
    func contentOffsetValue(_ value: Binding<CGFloat>) -> some View {
        return self
            .coordinateSpace(name: "scrollView")
            .onPreferenceChange(ContentOffsetObserverPreferenceKey.self) { offsetValue in
                DispatchQueue.main.async {
                    value.wrappedValue = min(offsetValue, 0)
                }
            }
    }
}

struct ContentOffsetObserverPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat { 0 }
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
