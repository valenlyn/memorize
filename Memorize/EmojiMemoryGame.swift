//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Valenlyn Chua on 1/6/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    @Published private var model: MemoryGame<String>
    private(set) var numberOfPairs: Int = 0
    private(set) var theme: EmojiMemoryTheme
    
    init(theme: EmojiMemoryTheme? = nil) {
        self.theme = theme ?? EmojiMemoryTheme.themes.randomElement()!
        let emojis = self.theme.emojis.shuffled()
        let numberOfPairs = self.theme.numberOfPairs < emojis.count ? self.theme.numberOfPairs : emojis.count
        model = MemoryGame(numberOfPairsOfCards: numberOfPairs) { emojis[$0] }
    }
    
    var score: Int {
        model.score
    }

    // MARK: - Access to the Model
    var cards: [Card] {
        model.cards
    }

    // MARK: - Intent(s)
    func choose(card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        theme = EmojiMemoryTheme.themes.randomElement()!
        let emojis = theme.emojis.shuffled()
        let numberOfPairs = theme.numberOfPairs < emojis.count ? theme.numberOfPairs : emojis.count
        model = MemoryGame(numberOfPairsOfCards: numberOfPairs) { emojis[$0] }
    }
    
}

struct EmojiMemoryTheme {
    let name: String
    let emojis: [String]
    let color: Color
    var numberOfPairs: Int
    
    static var themes: [EmojiMemoryTheme] = [
        EmojiMemoryTheme(name: "animals", emojis: Array(Set(["🐻", "🐰", "🐭", "🐶", "🐮", "🐯"])), color: Color.red, numberOfPairs: 15),
        EmojiMemoryTheme(name: "vehicles", emojis: Array(Set(["🚎", "🚌", "🏎", "🚗", "🚙", "🚕"])), color: Color.blue, numberOfPairs: 6),
        EmojiMemoryTheme(name: "food", emojis: Array(Set(["🍗", "🍣", "🍟", "🥟", "🍜", "🌮", "🥪"])), color: Color.green, numberOfPairs: 7),
        EmojiMemoryTheme(name: "hearts", emojis: Array(Set(["❤️", "🧡", "💛", "💚", "💙", "💜", "🖤", "💖", "💘", "💝", "💗", "💓"])), color: Color.indigo, numberOfPairs: 10),
        EmojiMemoryTheme(name: "things", emojis: Array(Set(["🍄", "🎒", "👘", "🧶", "🧵", "🍋", "🍊", "🍘", "🍙"])), color: Color.mint, numberOfPairs: 6),
        EmojiMemoryTheme(name: "flags", emojis: Array(Set(["🇸🇬", "🇮🇩", "🇵🇱", "🇯🇵", "🇮🇹", "🇮🇪", "🇲🇬", "🇲🇹", "🇹🇯"])), color: Color.yellow, numberOfPairs: 10)
    ]
}
