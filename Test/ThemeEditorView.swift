//
//  ThemeEditorView.swift
//  Test
//
//  Created by Anne French on 10/30/20.
//

import SwiftUI

struct ThemeEditorView: View {
    var theme: Theme
    @Binding var showThemeEditor: Bool
    @State private var emoji: String = "😀"
    @State private var themeName: String = "Untitled"
    
    var body: some View {
//        NavigationView {
            ZStack {
                Text("Theme Editor").font(.headline).padding()
                HStack {
                    Spacer()
                    Button(action: {
                        self.showThemeEditor = false
                    }, label: { Text("Done") }).padding()
                }
            }
            Divider()
                Form {
                    TextField("Theme Name", text: $themeName)
                    Text("themeName")
                    TextEditor(text: .constant("Add Emoji"))
                    TextEditor(text: .constant("Emojis"))
                    DataInput(title: "Add Emoji", userInput: $emoji)
                }
                .navigationTitle(theme.name)
//        } // NavigationView
    }
} // ThemeEditorView

struct DataInput: View {
    var title: String
    @Binding var userInput: String
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            Text(title)
                .font(.headline)
            TextField("Enter \(title)", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct ThemeEditorView_Previews: PreviewProvider {
    
    static var previews: some View {
        ThemeEditorView(theme: testData[0], showThemeEditor: Binding.constant(true))
    }
}
