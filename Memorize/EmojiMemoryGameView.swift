//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Valenlyn Chua on 30/5/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            HStack {
                Text(game.theme.name)
                Spacer()
                Text("Score: \(game.score)")
            }
            .padding(.horizontal, 20)
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            game.choose(card: card)
                        }
                }
            }
            .foregroundColor(game.theme.color)
            .padding(.horizontal)
        }
        Spacer()
        Button("New Game") {
              game.restart()
        }
    }
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
  
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if (card.isFaceUp) {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                        .padding(DrawingConstants.piePadding)
                        .opacity(DrawingConstants.pieOpacity)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        })
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.65
        static let piePadding: CGFloat = 5
        static let pieOpacity: CGFloat = 0.5
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards.first!)
        return EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
//        EmojiMemoryGameView(game: game)
//            .preferredColorScheme(.dark)
    }
}
