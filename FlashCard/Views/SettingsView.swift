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
    @AppStorage("fontSize") private var fontSizeName: String = "Medium"
    @AppStorage("darkMode") private var darkMode: Bool = false
    
    var body: some View {
        
        Form {
            Section("Study") {
                Toggle("Show back first", isOn: $showBackFirst)
                Toggle("Shuffle cards", isOn: $shuffleCards)
                Stepper("Cards per session: \(cardsPerSession)",
                value: $cardsPerSession, in: 1...50)
            }
            
            Section("Appearance") {
                Picker("Color", selection: $themeColorName) {
                    Text("Blue").tag("Blue")
                    Text("Green").tag("Green")
                    Text("Orange").tag("Orange")
                    Text("Purple").tag("Purple")
                }
                
                Picker("Font Size", selection: $fontSizeName) {
                    Text("Small").tag("Small")
                    Text("Medium").tag("Medium")
                    Text("Large").tag("Large")
                }
                
                Toggle("Dark Mode", isOn: $darkMode)
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
