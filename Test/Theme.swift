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
    var pairCount = 8
    
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
          emojis: "🦇😱🙀😈🎃👻🍭🍬",
          pairCount: 8
    ),
    Theme(name: "Animals",
          backgroundColor: "pink",
          buttonColor: "yellow",
          emojis: "🐶🐱🐭🐹🦊🐰🐻🐼",
          pairCount: 7
    ),
    Theme(name: "Fruit",
          backgroundColor: "green",
          buttonColor: "red",
          emojis: "🍏🍎🍐🍊🍋🍌🍉🍇",
          pairCount: 6
    ),
    Theme(name: "Vehicles",
          backgroundColor: "gray",
          buttonColor: "blue",
          emojis: "🚗🚎🚒🚜🛵🚘🚍🛴",
          pairCount: 5
    ),
    Theme(name: "Flags",
          backgroundColor: "red",
          buttonColor: "gray",
          emojis: "🇦🇩🇦🇮🏳️‍🌈🇦🇸🇰🇿🇨🇴🇲🇷🇿🇦",
          pairCount: 4
    ),
    Theme(name: "Sports",
          backgroundColor: "orange",
          buttonColor: "gray",
          emojis: "⚽️🏀🏈⚾️🏉🎱🚵🏻‍♀️🚴🏼",
          pairCount: 3
    )
]


