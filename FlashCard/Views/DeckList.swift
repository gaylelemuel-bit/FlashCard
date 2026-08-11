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
    
    var body: some View {
        List {
            Section("Decks") {
                ForEach(store.decks) { deck in
                    NavigationLink {
                        StudyView(deck: deck)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(deck.name)
                                .font(.system(size: titleFontSize, weight: .semibold))
                            Text("\(deck.card.count) cards")
                                .font(.system(size: subtitleFontSize))
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
}

#Preview {
    NavigationStack {
        DeckList()
            .environmentObject(DeckStore())
    }
}
