//
//  WaveShape.swift
//  WaveEffectModifier
//
//  Created by Lidor Fadida on 12/07/2024.
//

import SwiftUI

struct WaveShape: Shape {
    var animatableData: AnimatableWaveConfiguration

    func path(in rect: CGRect) -> Path {
        let midY = rect.height * (1.0 - animatableData.progress)
        let path = UIBezierPath()
        path.move(to: CGPoint(x: .zero, y: midY))
        path.addCurve(
            to: CGPoint(x: rect.maxX, y: midY),
            controlPoint1: animatableData.controlPoint1,
            controlPoint2: animatableData.controlPoint2
        )
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.close()
        return Path(path.cgPath)
    }
}
