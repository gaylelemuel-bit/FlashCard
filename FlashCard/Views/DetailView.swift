//
//  DetailView.swift
//  FlashCard
//
//  Created by Lemuel Gayle on 8/11/26.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var store: DeckStore
    @State private var showingAddCard: Bool = false
    
    let deckID: UUID
    
    var body: some View {
        if let deck = store.deck(deckId: deckID) {
            List {
                Section {
                    NavigationLink {
                        StudyView(deck: deck)
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "play.circle.fill")
                                .font(.title2)
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Study this deck")
                                    .font(.headline)
                                Text("\(deck.card.count) cards ready")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.vertical, 6)
                    }
                }
                
                Section("Cards") {
                    if deck.card.isEmpty {
                        ContentUnavailableView("No Cards", systemImage: "rectangle.badge.plus", description: Text("Tap plus to add a card."))
                    } else {
                        ForEach(deck.card) { card in
                            VStack(alignment: .leading, spacing: 6) {
                                Text(card.front)
                                    .font(.headline)
                                Text(card.back)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 6)
                        }
                        .onDelete { offsets in
                            store.deleteCard(in: deckID, at: offsets)
                        }
                    }
                }
            }
            .navigationTitle(deck.name)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddCard = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddCard) {
                AddCardView(deckID: deckID)
                    .environmentObject(store)
            }
        } else {
            Text("Deck not found")
                .navigationTitle("Deck")
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(deckID: UUID())
    }.environmentObject(DeckStore())
}
