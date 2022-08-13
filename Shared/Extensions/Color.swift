/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 2
    Author: Pham Cong Minh
    ID: s3818102
    Created  date: 09/08/2022
    Last modified: ??/??/2022
*/

import Foundation
import SwiftUI

// Color extension to allow using custom color theme in Asset
extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let background = Color("BackgroundColor")
    let primaryText = Color("PrimaryTextColor")
    let secondaryText = Color("SecondaryTextColor")
    
    let ocean = Color("OceanColor")
    let red = Color("Red")
    let blue = Color("DodgerBlue")
    let midBlue = Color("EastBay")
    let darkBlue = Color("Tangaroa")
    let metal = Color("LimedSpruce")
    let gray = Color("Heather")
}
