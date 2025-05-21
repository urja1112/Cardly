//
//  ColorThemeManager.swift
//  Cardly
//
//  Created by urja 💙 on 2025-04-28.
//

import Foundation
import SwiftUICore


struct ColorThemeManager {
        static let background = Color("BackgroundColor")
       static let cardBackground = Color("CardBackgroundColor")
       static let accent = Color("AccentColor")
       static let textPrimary = Color("TextPrimaryColor")
       static let textSecondary = Color("TextSecondaryColor")
      static let softBlue = Color("SoftBlue")
      static let softPink = Color("SoftPink")
      static let softLavender = Color("LightLavender")
      static let accentBlue = Color("AccentColor")
    
    static let Peach = Color("Peach")
    //static let PowderAqua = Color("PowderAqua")
    static let SkyTeal = Color("SkyTeal")
    static let MintGreen = Color("MintGreen")
    static let PastelYellow = Color("PastelYellow")
   // static let CoralCream = Color("CoralCream")
   // static let LilacGray = Color("LilacGray")

    
    
    static let cardColors = ["softBlue", "softPink", "softLavender","Peach","SkyTeal","MintGreen","PastelYellow"]
      //static let textPrimary = Color("TextPrimaryColor")
    
    static let NameColor : [String : Color] = [
        "softBlue" : softBlue,
        "softPink" : softPink,
        "softLavender" : softLavender,
        "Peach" : Peach,
        "SkyTeal" : SkyTeal,
        "MintGreen" : MintGreen,
        "PastelYellow" : PastelYellow
    ]

}


