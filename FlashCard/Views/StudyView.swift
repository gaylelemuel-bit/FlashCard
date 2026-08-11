//
//  StudyView.swift
//  FlashCard
//
//  Created by Lemuel Gayle on 8/8/26.
//

import SwiftUI

struct StudyView: View {
    let deck: Deck
    
    @State private var index: Int = 0
    @State private var isFlipped: Bool = false
    @State private var sessionCards: [Flashcard] = []
    @State private var scores: [UUID: Bool] = [:]
    
    @AppStorage("showBackFirst") private var showBackFirst: Bool = false
    @AppStorage("shuffleCards") private var shuffleCards: Bool = true
    @AppStorage("cardsPerSession") private var cardsPerSession: Int = 10
    @AppStorage("themeColor") private var themeColorName: String = "Blue"
    
    var body: some View {
        VStack(spacing: 16) {
            if sessionCards.isEmpty {
                Text("No cards inside deck")
            } else {
                HStack {
                    Text("\(index + 1) / \(sessionCards.count)")
                    Spacer()
                    Text("Score: \(correctCount) / \(scores.count)")
                }
                .font(.headline)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(themeColor.opacity(0.15))
                        .frame(height: 220)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(themeColor, lineWidth: 2)
                        )
                    
                    Text(currentText)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .onTapGesture {
                    isFlipped.toggle()
                }
                
                HStack {
                    Button("Previous") {
                        prev()
                    }
                        .buttonStyle(.borderedProminent)
                        .disabled(index == 0)
                    
                    Button("Flip Card") {
                        isFlipped.toggle()
                    }
                        .buttonStyle(.borderedProminent)
                    
                    Button("Next") {
                        nextCard()
                    }
                        .buttonStyle(.borderedProminent)
                        .disabled(index == sessionCards.count - 1)
                }
                
                HStack {
                    Button("Missed it") {
                        recordScore(false)
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Got it") {
                        recordScore(true)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .padding()
        .tint(themeColor)
        .onAppear {
            startSession()
        }
    }
    
    private var currentCard: Flashcard? {
        guard !sessionCards.isEmpty else { return nil }
        return sessionCards[index]
    }
    
    private var currentText: String {
        guard let card = currentCard else { return "" }
        
        let showingFront = showBackFirst ? isFlipped : !isFlipped
        
        return showingFront ? card.front : card.back
    }
    
    private var correctCount: Int {
        scores.values.filter { $0 }.count
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
    
    private func startSession() {
        var cards = deck.card
        if shuffleCards {
            cards.shuffle()
        }
        
        let limit = min(cardsPerSession, cards.count)
        sessionCards = Array(cards.prefix(limit))
        index = 0
        isFlipped = false
        scores = [:]
    }
    
    private func nextCard() {
        if index < sessionCards.count - 1 {
            index += 1
            isFlipped = false
        }
    }
    
    private func prev() {
        if index > 0 {
            index -= 1
            isFlipped = false
        }
    }
    
    private func recordScore(_ gotIt: Bool) {
        guard let card = currentCard else { return }
        scores[card.id] = gotIt
        nextCard()
    }
}

#Preview {
    NavigationStack {
        StudyView(deck: Deck(name: "Bible Scriptures", card: [
            Flashcard(front: "Hosea 4:6", back: "My people are destroyed for lack of knowledge."),
            Flashcard(front: "James 1:6", back: "Ask in faith, without doubting."),
            Flashcard(front: "Exodus 20", back: "God gives the Ten Commandments."),
            Flashcard(front: "Matthew 5:16", back: "Let your light shine before others.")
        ]))
    }
}
