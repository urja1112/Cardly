//
//  CardDetailView.swift
//  Cardly
//
//  Created by urja 💙 on 2025-04-28.
//

import SwiftUI

struct CardDetailView: View {
//    var randomColor : Color {
//        ColorThemeManager.cardColors.randomElement() ?? .white
//    }
    
    
    var name : String
    var title : String
    var company : String
    var cardColor : String
    var profileImageData: Data?

    var card : BusinessCard
    var body: some View {
        ZStack(alignment: .topTrailing){
            VStack {
                
                if let data = profileImageData, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                } else {
                    Image("defaultImage")
                }
                
                Text(name)
                    .font(.title2)
                    .bold()
                    .padding(.top)
                Text(title)
                    .font(.headline)
                //.padding()
                Text(company)
                    .font(.subheadline)
                
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(ColorThemeManager.NameColor[cardColor] ?? .gray)
            .cornerRadius(16)
            .padding(.horizontal)
            NavigationLink(destination: QRCodeView(card: card)) {
                Image(systemName: "square.and.arrow.up")
                    .padding(8)
                    .background(Color.white.opacity(0.8))
                    .clipShape(Circle())
                    .padding([.top, .trailing], 10)
            }
            .padding()
//            Button() {
//                QRCodeView(card: card)
//            } label: {
//                Image(systemName: "square.and.arrow.up")
//                    .padding(8)
//                    .background(Color.white.opacity(0.8))
//                    .clipShape(Circle())
//                    .padding([.top, .trailing], 10)
//            }
//            .padding()
        }
    }
    
}

#Preview {
    let sampleImageData = UIImage(systemName: "person.crop.circle")?.jpegData(compressionQuality: 0.8)
    CardDetailView(name: "Urja Desai", title: "iOS Developer", company: "ABC Corp", cardColor: "PastelYellow", card: BusinessCard(name: "urja", jobTitle: "ios", company: "xyz", emailAddress: "urja@gmail.com", phoneNumber: "88172712712", cardColor: "black", profileImageData: sampleImageData))
}
