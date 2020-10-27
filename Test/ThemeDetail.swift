//
//  ThemeDetail.swift
//  Test
//
//  Created by Anne French on 10/22/20.
//

import SwiftUI

struct ThemeDetail: View {
    var theme: Theme
    @State var emoji: String
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Theme Name", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    TextEditor(text: .constant("Add Emoji"))
                    TextEditor(text: .constant("Emojis"))
                    DataInput(title: "Add Emoji", userInput: $emoji)
                    
                }
                .navigationTitle(theme.name)
                
                
            }
            
        } // NavigationView
        
    }
}

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

struct ThemeDetail_Previews: PreviewProvider {
    static var previews: some View {
        ThemeDetail(theme: testData[0], emoji: "😊")
    }
}
