//
//  ContentView.swift
//  Test
//
//  Created by Anne French on 10/21/20.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var store: ThemeStore
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes) { theme in
                    ThemeCell(store: store, theme: theme)
                }
                .onMove(perform: moveThemes)
                .onDelete(perform: deleteThemes)

            }
            .navigationBarTitle("Memorize")
            .navigationBarItems(
                leading: Button(action: {
                    addTheme()
                }, label: {
                    Image(systemName: "plus").imageScale(.large)
                }),
                trailing: EditButton()
            )
            .environment(\.editMode, $editMode)
            
        } // NavigationView
    } // body View

    func addTheme() {
        withAnimation {
            store.themes.append(Theme(name: "New Theme",
                pairCount: 3 ))
        }
    }

    func moveThemes(from: IndexSet, to: Int) {
        withAnimation {
            store.themes.move(fromOffsets: from, toOffset: to)
        }
    }

    func deleteThemes(offsets: IndexSet) {
        withAnimation {
            store.themes.remove(atOffsets: offsets)
        }
    }
} // ContenView

struct ThemeCell: View {
    @ObservedObject var store: ThemeStore
    
    var theme: Theme // passed in just ONE theme
    
    var body: some View {
        NavigationLink( destination: ThemeDetail(theme: theme, emoji: "😊")) {
            
            VStack(alignment: .leading) {
                Text(theme.name)
                    .foregroundColor(self.store.getThemeColor(theme.buttonColor))
                Text(theme.emojis)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        } // NavigationLink
    } // body
} // ThemeCell View


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: testStore)
    }
}

