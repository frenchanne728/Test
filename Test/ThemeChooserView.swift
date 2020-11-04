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
    
    @State var theme: Theme
    @Binding var editMode: EditMode
    
    @State private var showThemeEditor = false

    var body: some View {
        //tbd: replace destination with game view
       NavigationLink( destination: Text(theme.name)
                            .navigationBarTitle(self.store.getName(for: theme))) {
        HStack {
                Text(self.editMode.isEditing ? "✏️" : "")
                    .onTapGesture {
                        self.showThemeEditor = true
                    }.popover(isPresented: $showThemeEditor) {
                        ThemeEditorView(chosenTheme: self.$theme,
                                        isShowing: self.$showThemeEditor)
                            .environmentObject(self.store)
                    }

                VStack(alignment: .leading) {
                    EditableText(self.store.getName(for: theme), isEditing: self.editMode.isEditing) { name in
                        self.store.setName(name, for: theme)
                    }
                    .foregroundColor(self.store.getThemeColor(theme.buttonColor))
                    
                    Text(String(theme.emojis.substring(to: theme.pairCount)))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                } // VStack
            } // HStack
        } // NavigationLink
    } // body
} // ThemeCell View

struct ThemeEditorView: View {
    @EnvironmentObject var store: ThemeStore
    
    @Binding var chosenTheme: Theme
    @Binding var isShowing: Bool
    @State private var themeName: String = ""
    @State private var emojisToAdd: String = ""

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text("Theme Editor").font(.headline).padding()
                HStack {
                    Spacer()
                    Button(action: {
                        self.isShowing = false
                    }, label: { Text("Done") }).padding()
                }
            }
            Divider()
            Form {
                Section {
                    TextField("Theme Name", text: $themeName, onEditingChanged: { began in
                        if !began {
                            self.store.renameTheme(self.chosenTheme, to: self.themeName)
                        }
                    })
                    TextField("Add Emoji", text: $emojisToAdd, onEditingChanged: { began in
                        if !began {
                            self.chosenTheme = self.store.addEmoji(self.emojisToAdd, toTheme: self.chosenTheme)
                            self.emojisToAdd = ""
                        }
                    })
                }
                Section(header: Text("Remove Emoji")) {
                    Grid(chosenTheme.emojis.map { String($0) }, id: \.self) { emoji in
                        Text(emoji)
                            .onTapGesture {
                                self.chosenTheme = self.store.removeEmoji(emoji, fromTheme: self.chosenTheme)
                                print("Emojis now in chosen theme: \(self.chosenTheme.emojis)")
                        }
                    }
                }
            } // Form
        } // VStack
        .onAppear { self.themeName = self.store.themeNames[self.chosenTheme] ?? "" }
    }
} // ThemeEditorView

struct ThemeChooserView_Previews: PreviewProvider {

    static var previews: some View {
        ThemeChooserView(store: testStore)
    }
}


