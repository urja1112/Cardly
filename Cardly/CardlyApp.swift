//
//  CardlyApp.swift
//  Cardly
//
//  Created by urja 💙 on 2025-04-28.
//

import SwiftUI
import SwiftData

@main
struct CardlyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
               
        }
        .modelContainer(for : BusinessCard.self)
    }
}
