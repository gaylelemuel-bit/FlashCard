//
//  DeckList.swift
//  FlashCard
//
//  Created by Lemuel Gayle on 8/8/26.
//

import SwiftUI

struct DeckList: View {
    @EnvironmentObject var store: DeckStore
    
    var body: some View {
        List {
            Section("Decks") {
                ForEach(store.decks) { deck in
                    NavigationLink {
                        StudyView(deck: deck)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(deck.name)
                                .font(.headline)
                            Text("\(deck.card.count) cards")
                                .font(.subheadline)
                        }
                    }
                }
                
            }
        }
        .navigationTitle("FlashCards")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    SettingsView()
                } label: {
                        Image(systemName: "gearshape.fill")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DeckList()
            .environmentObject(DeckStore())
    }
}
