//
//  TestApp.swift
//  Test
//
//  Created by Anne French on 10/21/20.
//

import SwiftUI

@main
struct TestApp: App {
    
    @State private var store = testStore

    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
        }
    }
}
