//
//  FlashCardModel.swift
//  FlashCard
//
//  Created by Lemuel Gayle on 8/8/26.
//
import Foundation

struct Deck:Identifiable{
    
    let id:UUID = UUID()
    var name:String
    var card:[Flashcard]
}

struct Flashcard:Identifiable{
    
    let id:UUID = UUID()
    var front:String
    var back:String
    
}
