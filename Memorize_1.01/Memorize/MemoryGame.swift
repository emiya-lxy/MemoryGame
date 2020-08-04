//
//  MemoryGame.swift
//  Memorize
//
//  Created by 刘昕奕 on 2020/7/24.
//  Copyright © 2020 emiya_lxy. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    private(set) var plusScore: Int
    private(set) var minusScore: Int
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        //print("card chosen: \(card)")
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMached = true
                    cards[potentialMatchIndex].isMached = true
                    score = score + plusScore + Int((cards[chosenIndex].bonusRemaining + cards[potentialMatchIndex].bonusRemaining) * Double(plusScore))
                    print(score)
                } else {
                    score = score - minusScore
                    print(score)
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init (numOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        plusScore = numOfPairsOfCards
        minusScore = numOfPairsOfCards
        for pairIndex in 0..<numOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2, bonusTimeLimit: TimeInterval(numOfPairsOfCards)))
            cards.append(Card(content: content, id: pairIndex * 2 + 1, bonusTimeLimit: TimeInterval(numOfPairsOfCards)))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMached: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        
        var content: CardContent
        var id:Int

        // MARK: - Bonus Time
               
        // can be 0 which means "no bonus avaliable" for this card
        var bonusTimeLimit: TimeInterval
           
        // how long has this card ever been face up
        private var faceUpTime: TimeInterval {
           if let lastFaceUpDate = self.lastFaceUpDate {
               return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
           } else {
               return pastFaceUpTime
           }
        }

        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?

        // the accumulated time this card has been face up in the past
        var pastFaceUpTime: TimeInterval = 0

        // how much bonus time left before the opportunity runs out
        var bonusTimeRemaining: TimeInterval {
           max(0, bonusTimeLimit - faceUpTime)
        }

        // percentage of the bonus time remaining
        var bonusRemaining: Double {
           (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }

        // whether the card wasmatched during the bonus time period
        var hasEarnedBonus: Bool {
           isMached && bonusTimeRemaining > 0
        }

        // whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
           isFaceUp && !isMached && bonusTimeRemaining > 0
        }

        // called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
           if isConsumingBonusTime, lastFaceUpDate == nil {
               lastFaceUpDate = Date()
           }
        }

        // called when the card goes face down (or gets matched)
        private mutating func stopUsingBonusTime() {
           pastFaceUpTime = faceUpTime
           self.lastFaceUpDate = nil
        }
    }
}
