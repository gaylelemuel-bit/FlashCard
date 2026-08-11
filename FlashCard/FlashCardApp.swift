//
//  FlashCardApp.swift
//  FlashCard
//
//  Created by Lemuel Gayle on 8/8/26.
//

import SwiftUI
import Combine
@main
struct FlashCardApp: App {
    @StateObject var store = DeckStore()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                DeckList()
            }
            .environmentObject(store)
        }
    }
}
