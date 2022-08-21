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
    @State private var showInstruction = false

    var body: some View {
        VStack (spacing: 10) {
            ZStack {
                InvertCornerRectangle()
                    .fill(Color.theme.woodBackground)
                Text("Deploy your fleet 📌")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color.theme.primaryText)
                    .padding()
                NavigationLink(destination: HumanGameView(deployedFleet: createShip(deployedLocation: fleet), isReset: $isGoingToGameView),
                               isActive: $isGoingToGameView) {
                    EmptyView()
                }.isDetailLink(false)
            }
                .fixedSize(horizontal: false, vertical: true)

            Button {
                withAnimation {
                    showInstruction.toggle()
                }
            } label: {
                HStack (spacing: 10) {
                    Image(systemName: "chevron.up.square")
                        .rotationEffect(.degrees(self.showInstruction ? 0 : 180))
                        .animation(.easeInOut, value: showInstruction)
                    Text(showInstruction ? "Hide Instruction" : "Show Instruction")
                        .bold()
                    Image(systemName: "info.circle")
                }
                    .foregroundColor(Color.theme.secondaryText)

            }


            if showInstruction {
                VStack (alignment: .leading, spacing: 10) {
                    Text("1. Drag the ship to your prefered position")
                    Text("2. Tap to rotate the ship horizontally or vertically")
                    Text("3. You can only drag/rotate a ship on a valid postion: within the board and/or not overlapping with others")
                }
                    .font(.body)
                    .foregroundColor(Color.theme.primaryText)
                    .onTapGesture {
                    withAnimation {
                        showInstruction.toggle()
                    }
                }
            }

            Spacer()
            DeployOceanView(shipBaseCoordinate: shipBaseCoordinate, fleet: $fleet, shipStatus: $shipStatus)
            Spacer()
            HStack(spacing: 20) {
                Button (action: {
                    presentationMode.wrappedValue.dismiss()
                    BackgroundManager.instance.startPlayer(track: "homebackground", loop: true)
                }) {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.theme.primaryText, lineWidth: 3)
                        .overlay(
                        (Text(Image(systemName: "arrowshape.turn.up.backward")) + Text(" Back"))
                            .font(.headline)
                    )
                        .frame(height: 55)
                }
                    .controlSize(.regular)
                    .cornerRadius(20)

                Spacer()

                Button {
                    self.isGoingToGameView.toggle()
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
            .preferredColorScheme(.dark)
    }
}
