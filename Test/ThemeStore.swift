//
//  ThemeStore.swift
//  Test
//
//  Created by Anne French on 10/22/20.
//

import Foundation
import SwiftUI

class ThemeStore: ObservableObject {
    @Published var themes: [Theme]
    
    init(themes: [Theme] = []) {
        self.themes = themes
    }
    
    func getThemeColor(_ color: String) -> Color
    {
        var returnColor : Color
        
        switch color
        {
            case "black"    : returnColor = Color.black
            case "orange"   : returnColor = Color.orange
            case "pink"     : returnColor = Color.pink
            case "yellow"   : returnColor = Color.yellow
            case "green"    : returnColor = Color.green
            case "red"      : returnColor = Color.red
            case "gray"     : returnColor = Color.gray
            case "blue"     : returnColor = Color.blue
            default         : returnColor = Color.black
        }
        return returnColor
    }
    
} // class ThemeStore

let testStore = ThemeStore(themes: testData)

