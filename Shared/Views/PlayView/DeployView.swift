//
//  DeployView.swift
//  PirateWar
//
//  Created by Minh Pham on 17/08/2022.
//

import SwiftUI

struct DeployView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State var fleet = [[Coordinate]](repeating: [.zero], count: 5)
    @State var shipStatus = [(isVertical: Bool, topLocation: Coordinate)](repeating: (isVertical: true, topLocation: .zero), count: 5)
    @State var shipBaseCoordinate: [Coordinate] = [
        Coordinate(x: 0, y: 0),
        Coordinate(x: 1, y: 0),
        Coordinate(x: 2, y: 0),
        Coordinate(x: 3, y: 0),
        Coordinate(x: 4, y: 0),
    ]

    @State private var isGoingToGameView = false

    var body: some View {
        let _ = print(fleet)
        VStack {
            Text("Deploy your fleet 📌")
                .font(.title2)
                .bold()
                .foregroundColor(Color.theme.primaryText)
                .padding(.bottom, 20)
            VStack (alignment: .leading, spacing: 10) {
                Text("1. Drag the ship to your prefered position")
                Text("2. Tap to rotate the ship horizontally or vertically")
                Text("3. Note that you can only drag/rotate a ship on a valid postion (within the board and not overlapping with others")
                Text("4. Need reference? Refer to this link")
            }
                .font(.headline)
                .foregroundColor(Color.theme.primaryText)
            Spacer()
            DeployOceanView(shipBaseCoordinate: shipBaseCoordinate, fleet: $fleet, shipStatus: $shipStatus)
            Spacer()
            HStack {
                NavigationLink(destination: HumanGameView(deployedFleet: createShip(deployedLocation: fleet)),
                               isActive: $isGoingToGameView) {
                    EmptyView()
                }

                Button (action: { presentationMode.wrappedValue.dismiss() }) {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.theme.primaryText, lineWidth: 3)
                        .overlay(
                        Text("↩️ Back")
                            .font(.headline)
                    )
                        .frame(height: 55)
                }
                    .controlSize(.regular)
                    .cornerRadius(20)

                Spacer()

                Button {
                    print("Start Game")
                    self.isGoingToGameView = true
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.theme.primaryText, lineWidth: 3)
                        .overlay(
                        Text("🏴‍☠️ Start Game")
                            .font(.headline)
                    )
                        .frame(height: 55)
                }
                    .controlSize(.regular)
                    .cornerRadius(20)


            }
                .background(Color.theme.background)
                .foregroundColor(Color.theme.primaryText)
        }
            .padding()
            .navigationBarHidden(true)
            .background(Color.theme.background)
            .onAppear {
            BackgroundManager.instance.startPlayer(track: "deploy", loop: true)
        }
    }
        

    func createShip(deployedLocation: [[Coordinate]]) -> [Ship] {
        var deployedFleet: [Ship] = []
        for index in (0..<Fleet.shipsInFleet.count) {
            deployedFleet.append(Ship(Fleet.shipsInFleet[index].name, coordinates: deployedLocation[index]))
        }
        return deployedFleet
    }
}

struct DeployView_Previews: PreviewProvider {
    static var previews: some View {
        DeployView()
    }
}
