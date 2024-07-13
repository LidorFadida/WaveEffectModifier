//
//  AnimatableWaveConfiguration.swift
//  WaveEffectModifier
//
//  Created by Lidor Fadida on 12/07/2024.
//

import SwiftUI

struct AnimatableWaveConfiguration {
    var controlPoint1: CGPoint
    var controlPoint2: CGPoint
    var progress: CGFloat
}

extension AnimatableWaveConfiguration: VectorArithmetic {
    var magnitudeSquared: Double {
        Double(
            controlPoint1.x.magnitudeSquared + controlPoint1.y.magnitudeSquared +
            controlPoint2.x.magnitudeSquared + controlPoint2.y.magnitudeSquared +
            progress.magnitudeSquared
        )
    }
    
    mutating func scale(by rhs: Double) {
        controlPoint1.x.scale(by: rhs)
        controlPoint1.y.scale(by: rhs)
        controlPoint2.x.scale(by: rhs)
        controlPoint2.y.scale(by: rhs)
        progress.scale(by: rhs)
    }
    
    static var zero: AnimatableWaveConfiguration {
        AnimatableWaveConfiguration(controlPoint1: .zero, controlPoint2: .zero, progress: 0)
    }
    
    static func + (lhs: AnimatableWaveConfiguration, rhs: AnimatableWaveConfiguration) -> AnimatableWaveConfiguration {
        AnimatableWaveConfiguration(
            controlPoint1: CGPoint(
                x: lhs.controlPoint1.x + rhs.controlPoint1.x,
                y: lhs.controlPoint1.y + rhs.controlPoint1.y
            ),
            controlPoint2: CGPoint(
                x: lhs.controlPoint2.x + rhs.controlPoint2.x,
                y: lhs.controlPoint2.y + rhs.controlPoint2.y
            ),
            progress: lhs.progress + rhs.progress
        )
    }
    
    static func += (lhs: inout AnimatableWaveConfiguration, rhs: AnimatableWaveConfiguration) {
        lhs.controlPoint1.x += rhs.controlPoint1.x
        lhs.controlPoint1.y += rhs.controlPoint1.y
        lhs.controlPoint2.x += rhs.controlPoint2.x
        lhs.controlPoint2.y += rhs.controlPoint2.y
        lhs.progress += rhs.progress
    }

    static func - (lhs: AnimatableWaveConfiguration, rhs: AnimatableWaveConfiguration) -> AnimatableWaveConfiguration {
        AnimatableWaveConfiguration(
            controlPoint1: CGPoint(
                x: lhs.controlPoint1.x - rhs.controlPoint1.x,
                y: lhs.controlPoint1.y - rhs.controlPoint1.y
            ),
            controlPoint2: CGPoint(
                x: lhs.controlPoint2.x - rhs.controlPoint2.x,
                y: lhs.controlPoint2.y - rhs.controlPoint2.y
            ),
            progress: lhs.progress - rhs.progress
        )
    }
    
    static func -= (lhs: inout AnimatableWaveConfiguration, rhs: AnimatableWaveConfiguration) {
        lhs.controlPoint1.x -= rhs.controlPoint1.x
        lhs.controlPoint1.y -= rhs.controlPoint1.y
        lhs.controlPoint2.x -= rhs.controlPoint2.x
        lhs.controlPoint2.y -= rhs.controlPoint2.y
        lhs.progress -= rhs.progress
    }

    static func * (lhs: AnimatableWaveConfiguration, rhs: Double) -> AnimatableWaveConfiguration {
        AnimatableWaveConfiguration(
            controlPoint1: CGPoint(x: lhs.controlPoint1.x * rhs, y: lhs.controlPoint1.y * rhs),
            controlPoint2: CGPoint(x: lhs.controlPoint2.x * rhs, y: lhs.controlPoint2.y * rhs),
            progress: lhs.progress * rhs
        )
    }

    static func == (lhs: AnimatableWaveConfiguration, rhs: AnimatableWaveConfiguration) -> Bool {
        lhs.controlPoint1 == rhs.controlPoint1 &&
        lhs.controlPoint2 == rhs.controlPoint2 &&
        lhs.progress == rhs.progress
    }
}
