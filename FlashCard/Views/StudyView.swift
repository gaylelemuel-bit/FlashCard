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
    @AppStorage("fontSize") private var fontSizeName: String = "Medium"
    
    var body: some View {
        VStack(spacing: 20) {
            if sessionCards.isEmpty {
                ContentUnavailableView("No Cards", systemImage: "rectangle.stack.badge.plus", description: Text("Add cards to this deck before studying."))
            } else {
                HStack {
                    Text("Card \(index + 1) of \(sessionCards.count)")
                    Spacer()
                    Text("Score: \(correctCount) / \(scores.count)")
                }
                .font(.system(size: bodyFontSize, weight: .semibold))
                
                Text(showingFront ? "Front" : "Back")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .textCase(.uppercase)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(.background)
                        .shadow(color: .black.opacity(0.12), radius: 14, x: 0, y: 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 18)
                                .fill(themeColor.opacity(0.12))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(themeColor, lineWidth: 2)
                        )
                    
                    Text(currentText)
                        .font(.system(size: cardFontSize, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .padding(24)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 260)
                .onTapGesture {
                    isFlipped.toggle()
                }
                
                HStack {
                    Button {
                        prev()
                    } label: {
                        Label("Previous", systemImage: "chevron.left")
                    }
                    .buttonStyle(.bordered)
                    .disabled(index == 0)
                    
                    Button {
                        isFlipped.toggle()
                    } label: {
                        Label("Flip", systemImage: "arrow.triangle.2.circlepath")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button {
                        nextCard()
                    } label: {
                        Label("Next", systemImage: "chevron.right")
                    }
                    .buttonStyle(.bordered)
                    .disabled(index == sessionCards.count - 1)
                }
                
                HStack {
                    Button {
                        recordScore(false)
                    } label: {
                        Label("Missed it", systemImage: "xmark.circle")
                    }
                    .buttonStyle(.bordered)
                    
                    Button {
                        recordScore(true)
                    } label: {
                        Label("Got it", systemImage: "checkmark.circle.fill")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .padding()
        .tint(themeColor)
        .navigationTitle(deck.name)
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
        
        return showingFront ? card.front : card.back
    }
    
    private var showingFront: Bool {
        showBackFirst ? isFlipped : !isFlipped
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
    
    private var bodyFontSize: Double {
        switch fontSizeName {
        case "Small":
            return 15
        case "Large":
            return 21
        default:
            return 17
        }
    }
    
    private var cardFontSize: Double {
        switch fontSizeName {
        case "Small":
            return 20
        case "Large":
            return 30
        default:
            return 24
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
