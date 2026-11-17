import SwiftUI

extension Font {
    // Style Name        Weight      Size
    static let display          = Font.system(size: 42, weight: .black)
    static let headingL         = Font.system(size: 34, weight: .bold)
    static let headingM         = Font.system(size: 24, weight: .bold)
    static let titleCard        = Font.system(size: 24, weight: .semibold)
    static let bodyL            = Font.system(size: 20, weight: .regular)
    static let bodyM            = Font.system(size: 18, weight: .regular)
    static let bodySupporting   = Font.system(size: 18, weight: .light)
    static let captionM         = Font.system(size: 16, weight: .regular)
    static let captionS         = Font.system(size: 14, weight: .regular)
}

import SwiftUI

extension Color {
    static let appBackground = Color("Background")
    static let appCard = Color("Card")
    static let appPrimary = Color("Primary")
    static let appDestructive = Color("Semantic")
}
