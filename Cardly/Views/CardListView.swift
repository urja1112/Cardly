//
//  CardListView.swift
//  Cardly
//
//  Created by urja 💙 on 2025-04-28.
//

import SwiftUI
import SwiftData

struct CardListView: View {

    @Environment(\.modelContext) var context
    @State private var cardToDelete: BusinessCard?
    @State private var showDeleteConfirmation = false
    @Query var cards : [BusinessCard]
    @State private var searchText = ""
    @State private var selectedSort: SortOption = .name

    var filterCard : [BusinessCard] {
        let base = searchText.isEmpty ? cards : cards.filter {
               $0.name.localizedCaseInsensitiveContains(searchText) ||
               $0.company.localizedCaseInsensitiveContains(searchText) ||
               $0.jobTitle.localizedCaseInsensitiveContains(searchText)
           }
           
           switch selectedSort {
           case .name:
               return base.sorted { $0.name < $1.name }
           case .company:
               return base.sorted { $0.company < $1.company }
           case .recent:
               return base // SwiftData auto sorts by insertion unless you add a date field
           }
    }
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            ScrollView{
                Picker("Sort by", selection: $selectedSort) {
                    ForEach(SortOption.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                VStack(spacing : 20){
                if cards.isEmpty {
                    
                    Text("Please Click on + Button and add new card")
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 300,alignment: .centerFirstTextBaseline)
                    
                } else {
                    VStack(spacing: 20) {
                        ForEach(filterCard) { card in
                            NavigationLink( destination: CreateEditCardView( card: card)) {
                                CardDetailView(
                                    name: card.name,
                                    title: card.jobTitle,
                                    company: card.company,
                                    cardColor: card.cardColor,
                                    profileImageData: card.profileImageData,
                                    card: card
                                    
                                )
                            }
                            .buttonStyle(.plain)
                            .contextMenu{
                                Button(role : .destructive) {
//                                    withAnimation {
//                                        context.delete(card)
//                                    }
                                    
                                    cardToDelete = card
                                           showDeleteConfirmation = true
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    
                    }
                }
            }
            
           
        }
            .scrollIndicators(.hidden)
            .searchable(text: $searchText, prompt: "Search cards")

            .alert("Are you Sure you want to delete the card",isPresented: $showDeleteConfirmation,presenting: cardToDelete){ card in
                Button("Delete", role: .destructive) {
                    withAnimation {
                        context.delete(card)
                    }
                }
                Button("Cancel", role: .cancel) {}
            }
            
       
            NavigationLink(destination: CreateEditCardView()) {
                Image(systemName: "plus")
                    .font(.title.weight(.semibold))
                    .padding()
                    .background(ColorThemeManager.accentBlue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
            .padding(.trailing, 20)
            .padding(.bottom, 20)
         
        }
      
    }
}

#Preview {
    //CardListView()
    do {
         let config = ModelConfiguration(isStoredInMemoryOnly: true)
         let container = try ModelContainer(for: BusinessCard.self, configurations: config)
         return CardListView().modelContainer(container)
     } catch {
         return Text("Failed to load preview")
     }
}

enum SortOption: String, CaseIterable, Identifiable {
    case name = "Name (A–Z)"
    case company = "Company"
    case recent = "Recently Added"
    
    var id: String { rawValue }
}
