//
//  QRCodeView.swift
//  Cardly
//
//  Created by urja 💙 on 2025-04-28.
//

import SwiftUI

struct QRCodeView: View {
    let card : BusinessCard
    @State private var showShareSheet = false
    @State private var qrImage: UIImage? = nil
    var body: some View {
        NavigationStack {
            VStack {
                Text("\(card.name)'s QR Code")
                    .font(.title)
                if let image = QRCodeGenerator.generate(from: Cardformatter.vCardString(for: card)) {
                    Image(uiImage: image)
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .onAppear{
                            qrImage = image
                        }
                }
                else {
                    Text("Failed to generate QR code")
                }
                if let qrImage = qrImage,
                   let imageData = qrImage.pngData() {
                    
                    ShareLink(
                        item: imageData,
                        preview: SharePreview("\(card.name)'s QR Code", image: Image(uiImage: qrImage))
                    ) {
                        Label("Share QR", systemImage: "qrcode")
                    }
                }

                if let fileURL = VCardExporter.exportVcard(for: card) {
                    ShareLink(
                        item: fileURL,
                        preview: SharePreview("\(card.name)'s Contact Card", image: Image(systemName: "person.crop.circle"))
                    ) {
                        Label("Share Contact", systemImage: "person.crop.circle")
                    }
                }
            }
            .padding()
            .navigationTitle("Your QR Code")
        }
    }
}

#Preview {
    let sampleImageData = UIImage(systemName: "person.crop.circle")?.jpegData(compressionQuality: 0.8)

    QRCodeView(card: BusinessCard(name: "Urja", jobTitle: "iOS", company: "Xyz", emailAddress: "urjadesai.08@gmail.com", phoneNumber: "8254888858", cardColor: "black", profileImageData: sampleImageData ))
}
