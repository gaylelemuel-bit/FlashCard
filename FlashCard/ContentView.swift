//
//  ContentView.swift
//  FlashCard
//
//  Created by Lemuel Gayle on 8/8/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var deckStore = DeckStore()
    @AppStorage("darkMode") private var darkMode: Bool = false
    
    var body: some View {
        NavigationStack {
            DeckList()
                .environmentObject(deckStore)
        }
        .preferredColorScheme(darkMode ? .dark : .light)
    }
}

#Preview {
    ContentView()
}
