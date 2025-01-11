//
//  MealFonts.swift
//  MealMate
//
//  Created by Mahesh Kumar on 11/01/25.
//

import Foundation
import UIKit
import SwiftUI


enum MMFontSize: CGFloat {
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
    case eleven = 11
    case twelve = 12
    case thirteen = 13
    case fourteen = 14
    case fifteen = 15
    case sixteen = 16
    case seventeen = 17
    case eighteen = 18
    case twenty = 20
    case twentyTwo = 22
    case twentyFour = 24
    case twentySix = 26
    case thirty = 30
    case fourtyFive = 45
    case fifty = 50
    
    var value: CGFloat {
        return self.rawValue
    }
}

enum MMFonts: String {
    
    // Different weights of the Poppins font
   
    case regular = "DMSans-Regular"
    case medium = "DMSans-Medium"
    case semibold = "Poppins-SemiBold"
    case bold = "DMSans-Bold"
    case boldItalic = "DMSans-BoldItalic"
    case italic = "DMSans-Italic"
    case mediumItalic = "DMSans-MediumItalic"
    
    // Function to apply the font with a scaling size
    func withSize(_ size: MMFontSize) -> Font {
        let scaledSize = size.value * MMFonts.scaleFactor
        return Font.custom(self.rawValue, size: scaledSize)
    }

    private static var scaleFactor: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        switch screenWidth {
        case 0..<375: // Small devices (e.g., iPhone SE)
            return 0.9
        case 375..<428: // Medium devices (e.g., iPhone 14)
            return 1.1
        default: // Large devices (e.g., iPhone 14 Pro Max)
            return 1.1
        }
    }
}

/// Register fonts in bundle
/// - Parameter bundle: pod default bundle
func registerFonts(from bundle: Bundle) {
    guard let fontURLs = bundle.urls(forResourcesWithExtension: "ttf", subdirectory: nil) else { return }

    for url in fontURLs {
        var errorRef: Unmanaged<CFError>?
        CTFontManagerRegisterFontsForURL(url as CFURL, .process, &errorRef)
    }
}
