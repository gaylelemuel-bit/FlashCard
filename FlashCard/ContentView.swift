//
//  ContentView.swift
//  FlashCard
//
//  Created by Lemuel Gayle on 8/8/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var deckStore = DeckStore()
    
    var body: some View {
        NavigationStack {
            DeckList()
                .environmentObject(deckStore)
        }
    }
}

#Preview {
    ContentView()
}
