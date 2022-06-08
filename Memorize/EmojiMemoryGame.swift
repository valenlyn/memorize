//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Valenlyn Chua on 1/6/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
        @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
        private(set) var numberOfPairs: Int = 0

        static func createMemoryGame() -> MemoryGame<String> {
            let emoji: [String] = ["👻","🎃","😎","🤡","🙈","🌞","⚽️","🔨","😈","🧟","🕷","🕸"].shuffled()
            let numberOfPairs = (2...5).randomElement()!
            return MemoryGame(numberOfPairsOfCards: numberOfPairs) { emoji[$0] }
        }

        // MARK: - Access to the Model
        var cards: [MemoryGame<String>.Card] {
            model.cards
        }

        // MARK: - Intent(s)
        func choose(card: MemoryGame<String>.Card) {
            model.choose(card)
        }
    
}
