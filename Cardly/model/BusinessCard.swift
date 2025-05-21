//
//  BusinessCard.swift
//  Cardly
//
//  Created by urja 💙 on 2025-04-28.
//

import Foundation
import SwiftData
import SwiftUICore

@Model
class BusinessCard {
    var name : String
    var jobTitle : String
    var company : String
    var emailAddress : String
    var phoneNumber : String
    var cardColor : String
    var profileImageData: Data?
    
    init(name: String, jobTitle: String, company: String, emailAddress: String, phoneNumber: String, cardColor: String, profileImageData : Data?) {
        self.name = name
        self.jobTitle = jobTitle
        self.company = company
        self.emailAddress = emailAddress
        self.phoneNumber = phoneNumber
        self.cardColor = cardColor
        self.profileImageData = profileImageData
    }
}
