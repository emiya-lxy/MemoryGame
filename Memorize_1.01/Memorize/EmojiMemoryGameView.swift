//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by 刘昕奕 on 2020/7/22.
//  Copyright © 2020 emiya_lxy. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Grid(viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        withAnimation(.linear(duration: self.animationDuration)) {
                            self.viewModel.choose(card: card)
                        }
                    }
            .padding(5)
            }
                .padding()
                .foregroundColor(EmojiMemoryGame.emojiTheme.getColor)
            HStack {
                Button(action: {
                    withAnimation(.easeInOut) {
                        self.viewModel.resetGame()
                    }
                }, label: { Text("New Game")})
                Button(action: {
                    withAnimation(.easeInOut) {
                        self.viewModel.restartGame()
                    }
                }, label: { Text("Restart")})
            }
            HStack {
                Text(EmojiMemoryGame.emojiTheme.getName)
                Text("Score: \(viewModel.score)")
            }
        }
    }
    
    // MARK: -Animation Constants
    
    private let animationDuration: Double = 0.7
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0

    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }

    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMached {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                            .onAppear() {
                                self.startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                    }
                }
                .padding(5).opacity(0.4)
                .transition(.identity)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMached ? 360 : 0))
                    .animation(Animation.linear(duration: 1))
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
        }
    }
    
    // MARK: - Drawing Constants
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
