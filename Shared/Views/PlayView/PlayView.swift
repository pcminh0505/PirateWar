//
//  PlayView.swift
//  PirateWar
//
//  Created by Minh Pham on 09/08/2022.
//

import SwiftUI

struct PlayView: View {
    var body: some View {
        VStack {
            ToolbarView()
            OceanView()
        }
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
    }
}
