//
//  EmojiTheme.swift
//  Memorize
//
//  Created by 刘昕奕 on 2020/8/1.
//  Copyright © 2020 emiya_lxy. All rights reserved.
//

import SwiftUI

struct EmojiTheme {
    var emojiTheme: Theme
    
    var getName: String {
        return emojiTheme.name
    }
    
    var getArray: Array<String> {
        return emojiTheme.array
    }
    
    var getColor: Color {
        return emojiTheme.color
    }
    
    init () {
        let array = [Theme.halloween, Theme.sport, Theme.food, Theme.flag, Theme.face, Theme.animal]
        var theme = array[Int.random(in: 0..<array.count)]
        emojiTheme = Theme(name: theme.name, color: theme.color) {
            theme.array.shuffle()
            return Array(theme.array.prefix(Int.random(in: 2...theme.array.count)))
        }
    }

}
