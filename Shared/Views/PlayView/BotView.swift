//
//  BotView.swift
//  PirateWar
//
//  Created by Minh Pham on 17/08/2022.
//

import SwiftUI

struct BotView: View {
    var body: some View {
        VStack {
            DeployView()
            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
        .background(Color.theme.background)
    }
    
}

struct BotView_Previews: PreviewProvider {
    static var previews: some View {
        BotView()
    }
}
