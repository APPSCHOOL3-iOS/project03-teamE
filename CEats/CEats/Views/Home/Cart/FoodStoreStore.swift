//
//  FoodStoreStore.swift
//  CEats
//
//  Created by Jisoo HAM on 2023/09/15.
//

import SwiftUI

struct CEatsImg: ViewModifier {
    func body(content: Content) -> some View {
        content
            .aspectRatio(contentMode: ContentMode.fill)
            .frame(width: 0, height: 30)
            .foregroundColor(Color.black)
    }
}

struct CEatsTextColor: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20))
            .foregroundColor(color)
            .padding()
    }
}

extension View {
    func cEatsTextColor(color: Color) -> some View {
        modifier(CEatsTextColor(color: color))
    }
    func cEatsImg() -> some View {
        modifier(CEatsImg())
    }
}