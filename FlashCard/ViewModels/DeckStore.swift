//
//  DeckStore.swift
//  FlashCard
//
//  Created by Lemuel Gayle on 8/8/26.
//

import Foundation
import Combine

@MainActor
class DeckStore: ObservableObject {
    
    @Published var decks: [Deck] = [] {
        didSet {
            if shouldPersist {
                save()
            }
        }
    }
    
    private let shouldPersist: Bool
    private let store = FileStore(fileName: "decks.json")
    
    init(shouldPersist: Bool = true) {
        let isPreview = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
        self.shouldPersist = shouldPersist && !isPreview
        
        load()
        if decks.isEmpty {
            decks = sampleDecks
            if shouldPersist {
                save()
            }
        }
    }
    
    private func load() {
        guard shouldPersist else {
            decks = sampleDecks
            return
        }
        
        do{
            decks = try store.load([Deck].self)
        }catch{
            decks = []
        }
    }
    
    private func save() {
        do{
            try store.save(decks)
        }catch{
            print("Could not save our decks..\(error.localizedDescription)")
        }
    }
    
    
    
    //mark: challenge 1
    func deck(deckId: UUID) -> Deck? {
        decks.first { $0.id == deckId }
    }
    
    // mark:challenge 2
    func addDeck(deck: Deck) {
        let newDeck = Deck(name: deck.name, card: deck.card)
        decks.append(newDeck)
    }
    
    func updateDeck(deckID: UUID, name: String) {
        guard let i = decks.firstIndex(where: { $0.id == deckID }) else {
            return
        }
        
        decks[i].name = name
    }
    
    func deleteDeck(at offsets: IndexSet) {
        for index in offsets.sorted(by: >) {
            decks.remove(at: index)
        }
    }
    
    //mark:CRUD Operations
    func addCard(to deckID: UUID, front: String, back: String) {
        guard let i = decks.firstIndex(where: { $0.id == deckID }) else {
            return
        }
        
        decks[i].card.append(Flashcard(front: front, back: back))
    }
    
    func addcard(to deckID: UUID, front: String, back: String) {
        addCard(to: deckID, front: front, back: back)
    }
    
    func updateCard(in deckID: UUID, cardID: UUID, front: String, back: String) {
        guard let deckIndex = decks.firstIndex(where: { $0.id == deckID }),
              let cardIndex = decks[deckIndex].card.firstIndex(where: { $0.id == cardID }) else {
            return
        }
        
        decks[deckIndex].card[cardIndex].front = front
        decks[deckIndex].card[cardIndex].back = back
    }
    
    func deleteCard(in deckID: UUID, at offsets: IndexSet) {
        guard let i = decks.firstIndex(where: { $0.id == deckID }) else {
            return
        }
        
        for index in offsets.sorted(by: >) {
            decks[i].card.remove(at: index)
        }
    }
    
    
    private let sampleDecks: [Deck] = [
        Deck(name: "Bible Scriptures", card: [
            Flashcard(front: "Hosea 4:6", back: "My people are destroyed for lack of knowledge."),
            Flashcard(front: "James 1:6", back: "Ask in faith, without doubting."),
            Flashcard(front: "Exodus 20", back: "God gives the Ten Commandments."),
            Flashcard(front: "Matthew 5:16", back: "Let your light shine before others.")
        ]),
        Deck(name: "Faith Verses", card: [
            Flashcard(front: "Hebrews 11:1", back: "Faith is the substance of things hoped for."),
            Flashcard(front: "Romans 10:17", back: "Faith comes by hearing the word of God."),
            Flashcard(front: "Proverbs 3:5", back: "Trust in the Lord with all your heart."),
            Flashcard(front: "Philippians 4:13", back: "I can do all things through Christ.")
        ])
    ]
    
}
