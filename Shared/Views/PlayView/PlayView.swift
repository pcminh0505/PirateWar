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
            Spacer()
//            StatusView(squareSize: UIScreen.main.bounds.width * 0.5 / 10)
        }
        .padding()
        .navigationBarHidden(true)
        .background(Color.theme.background)
        
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
            .preferredColorScheme(.dark)
            .environmentObject(Game())
            .previewInterfaceOrientation(.portrait)
    }
}
