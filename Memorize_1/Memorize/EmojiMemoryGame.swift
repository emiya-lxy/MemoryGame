//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by 刘昕奕 on 2020/7/24.
//  Copyright © 2020 emiya_lxy. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame(Theme: emojiTheme)
    static var emojiTheme = EmojiTheme()
    
    private static func createMemoryGame(Theme: EmojiTheme) -> MemoryGame<String> {
        let emojis = Theme.getArray
        return MemoryGame<String>(numOfPairsOfCards: emojis.count) { PairIndex in
            return emojis[PairIndex]
        }
    }
        
    // MARK: -Access to the model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: -Intents
    func choose(card: MemoryGame<String>.Card) {
        objectWillChange.send()
        model.choose(card: card)
    }
    
    func resetGame() {
        EmojiMemoryGame.emojiTheme = EmojiTheme()
        model = EmojiMemoryGame.createMemoryGame(Theme: EmojiMemoryGame.emojiTheme)
    }
    
    func restartGame() {
        model = EmojiMemoryGame.createMemoryGame(Theme: EmojiMemoryGame.emojiTheme)
    }
}
