//
//  AddCardView.swift
//  FlashCard
//
//  Created by Lemuel Gayle on 8/11/26.
//

import SwiftUI

struct AddCardView: View {
    @EnvironmentObject private var store: DeckStore
    @Environment(\.dismiss) private var dismiss
    
    let deckID: UUID
    
    @State private var front: String = ""
    @State private var back: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Add a new card") {
                    TextField("Question / term", text: $front)
                }
                Section("Back") {
                    TextField("Answer / Definition", text: $back)
                }
            }
            .navigationTitle("New Card")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        let f = front.trimmingCharacters(in: .whitespacesAndNewlines)
                        let b = back.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !f.isEmpty, !b.isEmpty else { return }
                        
                        store.addCard(to: deckID, front: f, back: b)
                        dismiss()
                    }
                    .disabled(
                        front.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                        back.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                    )
                }
            }
        }
    }
}

#Preview {
    AddCardView(deckID: UUID())
        .environmentObject(DeckStore())
}
