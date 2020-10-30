//
//  ThemeStore.swift
//  Test
//
//  Created by Anne French on 10/22/20.
//

import SwiftUI
import Combine

class ThemeStore: ObservableObject {
    @Published var themes: [Theme]
    @Published private var themeNames = [Theme:String]()
    
    let name: String

    private var autosave: AnyCancellable?

//    init(themes: [Theme] = []) {
//        self.themes = themes
//    }
    
    init(named name: String = "Memorize Theme", themes: [Theme] = []) {
        self.name = name
        self.themes = themes
        let defaultsKey = "ThemeStore.\(name)"
        
        themeNames = Dictionary(fromPropertyList: UserDefaults.standard.object(forKey: defaultsKey))
        if themeNames.isEmpty {
            for t in themes {
                _ = themeNames.updateValue(t.name, forKey: t)
            }
        }
        else {
            autosave = $themeNames.sink { names in
                UserDefaults.standard.set(names.asPropertyList, forKey: defaultsKey)
                
            }
        }
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
    
    func getName(for theme: Theme) -> String {
        if themeNames[theme] == nil {
            themeNames[theme] = "Untitled"
        }
        return themeNames[theme]!
    }
    func setName(_ name: String, for theme: Theme) {
        themeNames[theme] = name
    }
        
    func addTheme(named name: String = "Untitled") {
        themeNames[Theme()] = name
    }

    func removeTheme(_ theme: Theme) {
        themeNames[theme] = nil
    }
    
} // class ThemeStore

extension Dictionary where Key == Theme, Value == String {
    var asPropertyList: [String:String] {
        var uuidToName = [String:String]()
        for (key, value) in self {
            uuidToName[key.id.uuidString] = value
        }
        return uuidToName
    }
    
    init(fromPropertyList plist: Any?) {
        self.init()
        let uuidToName = plist as? [String:String] ?? [:]
        for uuid in uuidToName.keys {
            self[Theme(id: UUID(uuidString: uuid) ?? UUID())] = uuidToName[uuid]
        }
    }
}


let testStore = ThemeStore(themes: testData)
