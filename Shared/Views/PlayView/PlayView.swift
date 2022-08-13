//
//  PlayView.swift
//  PirateWar
//
//  Created by Minh Pham on 09/08/2022.
//

import SwiftUI

struct PlayView: View {
    @EnvironmentObject var game: Game
    
    var body: some View {
        VStack {
            ToolbarView()
            OceanView()
            FleetView(squareSize: UIScreen.main.bounds.width * 0.6 / 10)
        }

        .padding()
        .navigationBarHidden(true)
        
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
            .environmentObject(Game())
    }
}
