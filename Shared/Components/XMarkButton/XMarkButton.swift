//
//  XMarkButton.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 25/08/2022.
//

import SwiftUI

struct XMarkButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "xmark.circle")
                .foregroundColor(Color.theme.primaryText)
                .font(.headline)
        }
    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton()
    }
}
