//
//  QRCodeGenerator.swift
//  Cardly
//
//  Created by urja 💙 on 2025-04-28.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeGenerator {
    static func generate(from string: String) -> UIImage? {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
                 let scaled = outputImage.transformed(by: CGAffineTransform(scaleX: 10, y: 10))
                 if let cgImage = context.createCGImage(scaled, from: scaled.extent) {
                     return UIImage(cgImage: cgImage)
                 }
             }
        return nil
    }
}

struct Cardformatter {
    static func vCardString(for card : BusinessCard) -> String {
        let nameParts = card.name.split(separator: " ", maxSplits: 1).map(String.init)
             let firstName = nameParts.first ?? ""
             let lastName = nameParts.count > 1 ? nameParts[1] : ""

             return """
             BEGIN:VCARD
             VERSION:3.0
             N:\(lastName);\(firstName)
             FN:\(card.name)
             TITLE:\(card.jobTitle)
             ORG:\(card.company)
             TEL:\(card.phoneNumber)
             EMAIL:\(card.emailAddress)
             END:VCARD
             """
         }
}
