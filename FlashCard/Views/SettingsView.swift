//
//  SettingsView.swift
//  FlashCard
//
//  Created by Lemuel Gayle on 8/8/26.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("showBackFirst") private var showBackFirst: Bool = false
    @AppStorage("shuffleCards") private var shuffleCards: Bool = true
    @AppStorage("cardsPerSession") private var cardsPerSession: Int = 10
    @AppStorage("themeColor") private var themeColorName: String = "Blue"
    
    var body: some View {
        
        Form {
            Section("Study") {
                Toggle("Show back first", isOn: $showBackFirst)
                Toggle("Shuffle cards", isOn: $shuffleCards)
                Stepper("Cards per session: \(cardsPerSession)",
                value: $cardsPerSession, in: 1...50)
            }
            
            Section("Theme") {
                Picker("Color", selection: $themeColorName) {
                    Text("Blue").tag("Blue")
                    Text("Green").tag("Green")
                    Text("Orange").tag("Orange")
                    Text("Purple").tag("Purple")
                }
            }
            
            Section("About") {
                Text("Created by Lemuel Gayle")
            }
        }
    }
}

#Preview {
    SettingsView()
}
