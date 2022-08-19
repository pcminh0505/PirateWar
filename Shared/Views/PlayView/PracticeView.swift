//
//  PracticeView.swift
//  PirateWar
//
//  Created by Minh Pham on 09/08/2022.
//

import SwiftUI

struct PracticeView: View {
    @StateObject var game = Game()
    
    var body: some View {
        VStack {
            ToolbarView()
                .environmentObject(game)
            OceanView(isDeployedFleet: false)
                .environmentObject(game)
            Spacer()
//            StatusView(squareSize: UIScreen.main.bounds.width * 0.5 / 10)
        }
        .padding()
        .navigationBarHidden(true)
        .background(Color.theme.background)
        
    }
}

struct Practice_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView()
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
    }
}
