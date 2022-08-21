//
//  InvertCornerRectangle.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 20/08/2022.
//

import SwiftUI

struct InvertCornerRectangle: Shape {

    func path (in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX + 15, y: rect.minY))
        
        path.addLine(to: CGPoint(x: rect.maxX - 15, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + 15))
//        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY + 25), control: CGPoint(x: rect.maxX-25, y: rect.minY+25))

        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - 15))
        path.addLine(to: CGPoint(x: rect.maxX - 15, y: rect.maxY))
//        path.addQuadCurve(to: CGPoint(x: rect.maxX - 25, y: rect.maxY), control: CGPoint(x: rect.maxX-25, y: rect.maxY-25))
    
        path.addLine(to: CGPoint(x: rect.minX + 15, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - 15))
//        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY - 25), control: CGPoint(x: rect.minX+25, y: rect.maxY-25))
        
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minX + 15))
        path.addLine(to: CGPoint(x: rect.minX + 15, y: rect.minY))
//        path.addQuadCurve(to: CGPoint(x: rect.minX + 25, y: rect.minY), control: CGPoint(x: rect.minX+25, y: rect.minY+25))
        path.closeSubpath()
        return path
    }

}

struct CurvedSideRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        InvertCornerRectangle()
            .frame(height: 300)
    }
}
