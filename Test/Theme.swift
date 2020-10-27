//
//  Theme.swift
//  Test
//
//  Created by Anne French on 10/22/20.
//

import Foundation
import Combine

struct Theme: Identifiable, Equatable, Hashable {
    var id = UUID()
    var name: String = "Untitled"
    var backgroundColor: String = "black"
    var buttonColor: String = "orange"
    var emojis = String()
    var pairCount = 3
    
    static func == (lhs: Theme, rhs: Theme) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

let testData = [
    Theme(name: "Halloween",
          backgroundColor: "black",
          buttonColor: "orange",
          emojis: "🦇😱🙀😈🎃👻🍭🍬"
    ),
    Theme(name: "Animals",
          backgroundColor: "pink",
          buttonColor: "yellow",
          emojis: "🐶🐱🐭🐹🦊🐰🐻🐼"
    ),
    Theme(name: "Fruit",
          backgroundColor: "green",
          buttonColor: "red",
          emojis: "🍏🍎🍐🍊🍋🍌🍉🍇"
    ),
    Theme(name: "Vehicles",
          backgroundColor: "gray",
          buttonColor: "blue",
          emojis: "🚗🚎🚒🚜🛵🚘🚍🛴"
    ),
    Theme(name: "Flags",
          backgroundColor: "red",
          buttonColor: "gray",
          emojis: "🇦🇩🇦🇮🏳️‍🌈🇦🇸🇰🇿🇨🇴🇲🇷🇿🇦"
    ),
    Theme(name: "Sports",
          backgroundColor: "orange",
          buttonColor: "gray",
          emojis: "⚽️🏀🏈⚾️🏉🎱🚵🏻‍♀️🚴🏼"
    )
]


