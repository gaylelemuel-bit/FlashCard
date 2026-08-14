//
//  DeckList.swift
//  FlashCard
//
//  Created by Lemuel Gayle on 8/8/26.
//

import SwiftUI

struct DeckList: View {
    @EnvironmentObject var store: DeckStore
    @AppStorage("fontSize") private var fontSizeName: String = "Medium"
    @AppStorage("themeColor") private var themeColorName: String = "Blue"
    @State private var showingAddDeck: Bool = false
    
    var body: some View {
        List {
            Section("Decks") {
                if store.decks.isEmpty {
                    ContentUnavailableView("No Decks", systemImage: "rectangle.stack", description: Text("Tap plus to add your first deck."))
                } else {
                    ForEach(store.decks) { deck in
                        NavigationLink {
                            DetailView(deckID: deck.id)
                                .environmentObject(store)
                        } label: {
                            HStack(spacing: 12) {
                                Image(systemName: "rectangle.stack.fill")
                                    .font(.title2)
                                    .foregroundStyle(themeColor)
                                    .frame(width: 34, height: 34)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(deck.name)
                                        .font(.system(size: titleFontSize, weight: .semibold))
                                    Text("\(deck.card.count) cards")
                                        .font(.system(size: subtitleFontSize))
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .padding(.vertical, 6)
                        }
                    }
                    .onDelete { offsets in
                        store.deleteDeck(at: offsets)
                    }
                }
            }
        }
        .navigationTitle("FlashCards")
        .tint(themeColor)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingAddDeck = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink {
                    SettingsView()
                } label: {
                    Image(systemName: "gearshape.fill")
                }
            }
        }
        .sheet(isPresented: $showingAddDeck) {
            AddDeckView()
                .environmentObject(store)
        }
    }
    
    private var titleFontSize: Double {
        switch fontSizeName {
        case "Small":
            return 16
        case "Large":
            return 22
        default:
            return 18
        }
    }
    
    private var subtitleFontSize: Double {
        switch fontSizeName {
        case "Small":
            return 13
        case "Large":
            return 18
        default:
            return 15
        }
    }
    
    private var themeColor: Color {
        switch themeColorName {
        case "Green":
            return .green
        case "Orange":
            return .orange
        case "Purple":
            return .purple
        default:
            return .blue
        }
    }
}

#Preview {
    NavigationStack {
        DeckList()
    }
    .environmentObject(DeckStore())
}
