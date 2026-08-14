//
//  Deck.swift
//  FlashCard
//
//  Created by Lemuel Gayle on 8/11/26.
//

import Foundation

struct Deck: Identifiable, Codable, Equatable {
    
    var id: UUID = UUID()
    var name: String
    var card: [Flashcard]
    
    init(id: UUID = UUID(), name: String, card: [Flashcard]) {
        self.id = id
        self.name = name
        self.card = card
    }
}
