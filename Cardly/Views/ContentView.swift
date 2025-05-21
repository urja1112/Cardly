//
//  ContentView.swift
//  Cardly
//
//  Created by urja 💙 on 2025-04-28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
    
        NavigationStack {
            CardListView()
            .navigationTitle("Cardly")
        }
       
        .padding()
    }
}

#Preview {
    ContentView()
}
