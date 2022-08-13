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
                ScaledShape(shape: Circle(), scale: circleScale)
                    .fill(circleColor())
            }
        }
    }

    func circleColor() -> Color {
        if (state == .hit) {
            return .red
        } else if (state == .sunk) {
            return .black
        } else if (state == .selected) {
            return .green
        } else {
            return .white
        }
    }
}

struct OceanZoneView_Previews: PreviewProvider {
    static var previews: some View {
        OceanZoneView(state: .constant(.miss))
    }
}
