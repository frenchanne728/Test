//
//  ThemeChooserView.swift
//  Test
//
//  Created by Anne French on 10/28/20.
//

import SwiftUI

struct ThemeChooserView: View {

    @ObservedObject var store: ThemeStore
    
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes) { theme in
                    return ThemeCell(store: store, theme: theme, editMode: $editMode)
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
        }
        .padding(0.0) // NavigationView
    } // body View

    func addTheme() {
        withAnimation {
            store.themes.append(defaultTheme)
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
} // ThemeChooserView

struct ThemeCell: View {
    @ObservedObject var store: ThemeStore
    
    var theme: Theme
    @Binding var editMode: EditMode
    
    @State private var showThemeEditor = false

    var body: some View {
        //tbd: replace destination with game view
        NavigationLink( destination: Text(theme.name)) {
            HStack {
                Text(self.editMode.isEditing ? "✏️" : "")
                    .onTapGesture {
                        self.showThemeEditor = true
                    }.popover(isPresented: $showThemeEditor) {
                        ThemeEditorView(theme: self.theme, showThemeEditor: self.$showThemeEditor)
//                            .environmentObject(self.store)
//                            .frame(minWidth: 300, minHeight: 500)
                    }

                VStack(alignment: .leading) {
//                Text(theme.name)
                    EditableText(self.store.getName(for: theme), isEditing: self.editMode.isEditing) { name in
                        self.store.setName(name, for: theme)
                    }     .foregroundColor(self.store.getThemeColor(theme.buttonColor))
                    Text(String(theme.emojis.substring(to: theme.pairCount)))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                } // VStack
            } // HStack
        } // NavigationLink
    } // body
} // ThemeCell View


struct ThemeChooserView_Previews: PreviewProvider {

    static var previews: some View {
        ThemeChooserView(store: testStore)
    }
}


