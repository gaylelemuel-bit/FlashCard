//
//  DeckStore.swift
//  FlashCard
//
//  Created by Lemuel Gayle on 8/8/26.
//

import Foundation
import Combine

class DeckStore: ObservableObject {
    @Published var decks: [Deck] = [
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
