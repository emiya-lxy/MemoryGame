//
//  Theme.swift
//  Memorize
//
//  Created by 刘昕奕 on 2020/8/3.
//  Copyright © 2020 emiya_lxy. All rights reserved.
//

import SwiftUI

struct Theme {
    var name: String
    var color: Color
    var array: Array<String>
    
    init (name: String, color: Color, array: Array<String>) {
        self.name = name
        self.color = color
        self.array = array
    }
    
    init (name: String, color: Color, getArray: () -> Array<String>) {
        self.name = name
        self.color = color
        self.array = getArray()
    }
    
    // MARK: -Themes
    static let halloween = Theme(name: "Halloween", color: Color.orange, array: ["👻","🎃","😈","🕷","🧛‍♀️"])
    
    static let sport = Theme(name: "Sport", color: Color.yellow, array: ["⚽️","🏀","🏈","⚾️","🏐","🎱","🥎","🥏","🏓","🏸","🏑"])
    
    static let flag = Theme(name: "Flag", color: Color.green, array: ["🇫🇷","🇺🇸","🇨🇳","🇬🇧","🇷🇺","🇮🇪","🇳🇴","🇯🇵","🇩🇪","🇰🇷","🇳🇱","🇨🇴","🇧🇪"])

    static let food = Theme(name: "Food", color: Color.blue, array: ["🍔","🌭","🍟","🍣","🥙","🥯","🥪"])
    
    static let face = Theme(name: "Face", color: Color.purple, array: ["😀","😁","😆","😃","😄","😐","😬","🙂","😊","😂","☺️"])

    static let animal = Theme(name: "Animal", color: Color.gray, array: ["🦆","🦉","🦇","🐌","🐢","🦍","🦛","🦈","🦗","🦂","🦎","🦒"])
    
    static let clothes = Theme(name: "Clothes", color: Color.red, array: ["👚","👘","👕","👙","🥼","👗","🥻","🩱"])
    
    static let random = Theme(name: "Random", color: Color.black) {
        return Theme.halloween.array+Theme.sport.array+Theme.flag.array+Theme.food.array+Theme.face.array+Theme.animal.array+Theme.clothes.array
    }
}
