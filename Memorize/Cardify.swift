//
//  Cardify.swift
//  Memorize
//
//  Created by Valenlyn Chua on 21/6/22.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    let isMatched: Bool
    
    init(isFaceUp: Bool, isMatched: Bool) {
        rotation = isFaceUp ? 0 : 180
        self.isMatched = isMatched
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue}
    }
    
    var rotation: Double // in degrees
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else {
                shape.fill()
            }
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(isFaceUp: Bool, isMatched: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, isMatched: isMatched))
    }
}
