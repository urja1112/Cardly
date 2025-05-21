//
//  VCardExporter.swift
//  Cardly
//
//  Created by urja 💙 on 2025-05-03.
//

import Foundation

struct VCardExporter {
    static func exportVcard(for card : BusinessCard) -> URL? {
        let vcard = Cardformatter.vCardString(for: card)
        let fileName = "\(card.name).vcf"
        let tempUrl = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        do {
            try vcard.write(to: tempUrl, atomically: true, encoding: .utf8)
            return tempUrl
        } catch {
            print("Error writing vCard file: \(error)")
            return nil
        }
    }
}
