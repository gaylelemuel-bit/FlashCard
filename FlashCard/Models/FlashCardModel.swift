//
//  FlashCardModel.swift
//  FlashCard
//
//  Created by Lemuel Gayle on 8/8/26.
//
import Foundation

struct Flashcard: Identifiable, Codable, Equatable {
    
    var id: UUID = UUID()
    var front: String
    var back: String
    
    init(id: UUID = UUID(), front: String, back: String) {
        self.id = id
        self.front = front
        self.back = back
    }
}
