//
//  AddDeckView.swift
//  FlashCard
//
//  Created by Lemuel Gayle on 8/11/26.
//

import SwiftUI

struct AddDeckView: View {
    @EnvironmentObject var store: DeckStore
    @Environment(\.dismiss) private var dismiss
    @State private var deckName: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("New Deck")) {
                    TextField("Deck name", text: $deckName)
                }
            }
            .navigationTitle("Add New Deck")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        let name = deckName.trimmingCharacters(in: .whitespacesAndNewlines)
                                                guard !name.isEmpty else { return }
                                                store.addDeck(deck: Deck(name: name, card: []))
                                                dismiss()
                    } label: {
                        Image(systemName: "plus")
                        Text("Add")
                    }.disabled(deckName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)

//                    Button("Add") {
//                        let name = deckName.trimmingCharacters(in: .whitespacesAndNewlines)
//                        guard !name.isEmpty else { return }
//                        store.addDeck(deck: Deck(name: name, card: []))
//                        dismiss()
//                    }
//                    .disabled(deckName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddDeckView().environmentObject(DeckStore())
    }
}
