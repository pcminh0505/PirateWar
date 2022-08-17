//
//  DraggableImage.swift
//  PirateWar
//
//  Created by Minh Pham on 16/08/2022.
//

import SwiftUI

enum DragState {
    case unknown
    case good
    case bad
}

struct DraggableImage: View {
    var name: String
    var length: Int
    var index: Int
    var squareSize: CGFloat
    var initCoordinate: Coordinate
    @Binding var shipStatus: (isVertical: Bool, topLocation: Coordinate)
    
    @State var dragAmount = CGSize.zero
    @State var accumulated = CGSize.zero
    @State var dragState = DragState.unknown

    var body: some View {
        Image(name)
            .resizable()
            .frame(width: squareSize, height: squareSize * CGFloat(length))
            .clipped()
            .shadow(color: dragColor, radius: dragAmount == .zero ? 0 : 10)
            .shadow(color: dragColor, radius: dragAmount == .zero ? 0 : 10)
            .offset(dragAmount) // This for drag
        .gesture(
            DragGesture(minimumDistance: squareSize * 0.1, coordinateSpace: .local)
                .onChanged {
                self.dragState = .unknown
                self.dragAmount = CGSize(width: $0.translation.width + self.accumulated.width, height: $0.translation.height + self.accumulated.height)
            }
                .onEnded { _ in
                var currentCoordinate = shipStatus.topLocation
                if shipStatus.isVertical {
                    currentCoordinate.x = initCoordinate.x + Int(dragAmount.width / squareSize)
                    currentCoordinate.y = initCoordinate.y + Int(dragAmount.height / squareSize)
                } else {
                    currentCoordinate.x = initCoordinate.y - Int(dragAmount.width / squareSize)
                    currentCoordinate.y = initCoordinate.y + Int(dragAmount.height / squareSize)
                }

                if Game().ocean.contains(currentCoordinate) {
                    self.dragAmount = CGSize(width: CGFloat(Int(dragAmount.width / squareSize)) * squareSize, height: CGFloat(Int(dragAmount.height / squareSize)) * squareSize)
                    self.dragState = .good
                    shipStatus.topLocation = currentCoordinate

                } else {
                    self.dragAmount = .zero
                }
                self.accumulated = self.dragAmount
            }
        )
    }

    var dragColor: Color {
        switch dragState {
        case .unknown:
            return Color.theme.gray
        case .good:
            return Color.clear
        case .bad:
            return Color.theme.red
        }
    }
}

struct DraggableImage_Previews: PreviewProvider {
    static var previews: some View {
        DraggableImage(name: "Cruiser", length: 5, index: 1, squareSize: 30, initCoordinate: Coordinate(x: 4, y: 0), shipStatus: .constant((isVertical: true, topLocation: Coordinate(x: 0, y: 0))))
    }
}
