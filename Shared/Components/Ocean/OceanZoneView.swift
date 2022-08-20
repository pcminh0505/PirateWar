//
//  OceanZoneView.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 12/08/2022.
//

import SwiftUI

struct OceanZoneView: View {
    @Binding var state: OceanZoneState
    private let circleScale = CGSize(width: 0.5, height: 0.5)

    var body: some View {
        ZStack {
            Rectangle()
                .strokeBorder(.black, lineWidth: 1)
                .background(Color.theme.ocean)
                .aspectRatio(1.0, contentMode: .fit)
                

            if (state != .clear) {
                statusImage()
            }
        }
    }
    func statusImage() -> some View {
        if (state == .hit) {
            return Image(systemName: "circle.circle.fill")
                .foregroundColor(Color.theme.red)
        } else if (state == .sunk) {
            return Image(systemName: "xmark")
                .foregroundColor(Color.black)
        } else if (state == .selected) {
            return Image(systemName: "scope")
                .foregroundColor(Color.theme.metal)
        } else {
            return Image(systemName: "circle")
                .foregroundColor(Color.white)
        }
    }
}

struct OceanZoneView_Previews: PreviewProvider {
    static var previews: some View {
        OceanZoneView(state: .constant(.miss))
    }
}
