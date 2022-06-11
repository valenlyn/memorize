//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Valenlyn Chua on 30/5/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
