//
//  CardViewModel.swift
//  Cardly
//
//  Created by urja 💙 on 2025-04-28.
//

import SwiftUICore
import UIKit

struct CardFormData {
    var name: String = ""
    var jobTitle: String = ""
    var company: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var selectedColor : String = ""
    var profileImage: UIImage? = nil

}


extension CardFormData {
    var isNamevalid : Bool{ !name.trimmingCharacters(in: .whitespaces).isEmpty}
    var isJobValid: Bool { !jobTitle.isEmpty }
    var isCompanyValid: Bool { !company.isEmpty }
    var isEmailValid: Bool { !email.isEmpty }
    var isPhoneValid: Bool { !phoneNumber.isEmpty }
}
