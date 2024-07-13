//
//  WaveEffect.swift
//  WaveEffectModifier
//
//  Created by Lidor Fadida on 12/07/2024.
//

import SwiftUI

struct WaveEffect<Style: ShapeStyle>: ViewModifier {
    private var progress: CGFloat
    @State private var internalProgress: CGFloat
    @State private var controlPoints: [AnimatableWaveConfiguration]
    private let initialTime: Date
    private let numberOfWaves: Int
    private let animationDuration: TimeInterval
    private let waveFlexibility: Double
    private let fill: (Int) -> Style
    private let wavesCoordinateSpace = "wavesContainer"
    
    init(
        progress: CGFloat,
        wavesCount: Int = 3,
        animationDuration: TimeInterval = 2.0,
        waveFlexibility: Double = 0.1,
        fill: @escaping (Int) -> Style
    ) {
        self.progress = progress
        self.numberOfWaves = wavesCount
        self.animationDuration = animationDuration
        self.waveFlexibility = waveFlexibility
        self.fill = fill
        self.initialTime = Date.now
        self._internalProgress = State(initialValue: min(max(progress, 0.0), 1.0))
        self._controlPoints = State(initialValue: Array(repeating: AnimatableWaveConfiguration(controlPoint1: .zero, controlPoint2: .zero, progress: progress), count: wavesCount))
    }
    
    func body(content: Content) -> some View {
        TimelineView(.animation(minimumInterval: animationDuration / 2.0)) { context in
            GeometryReader { proxy in
                ZStack(alignment: .bottom) {
                    content
                    wavesView
                }
                .coordinateSpace(name: wavesCoordinateSpace)
                .onChange(of: context.date) { value in
                    let rect = proxy.frame(in: .named(wavesCoordinateSpace))
                    withAnimation(.easeInOut(duration: animationDuration)) {
                        contextDidUpdate(rect: rect)
                    }
                }
                .onAppear {
                    let rect = proxy.frame(in: .named(wavesCoordinateSpace))
                    contextDidUpdate(rect: rect)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    private var wavesView: some View {
        ForEach(0..<numberOfWaves, id: \.self) { index in
            WaveShape(animatableData: controlPoints[index])
                .fill(fill(index))
        }
    }
    
    private func contextDidUpdate(rect: CGRect) {
        internalProgress = min(max(progress, 0.0), 1.0)
        let baseRangeDelta = Double(rect.height * waveFlexibility)
        let deltaIncrement = baseRangeDelta / Double(numberOfWaves)
        let randomOffsets = (0..<numberOfWaves * 2).map { index in
            let currentRangeDelta = baseRangeDelta + deltaIncrement * Double(index / 2)
            return Double.random(in: -currentRangeDelta...currentRangeDelta)
        }
        
        let controlPoint1X = CGFloat.random(in: 0...rect.width * 0.5)
        let controlPoint2X = CGFloat.random(in: rect.width * 0.5...rect.width)
        let baseY = rect.height * (1.0 - internalProgress)
        
        controlPoints = (0..<numberOfWaves).map { index in
            AnimatableWaveConfiguration(
                controlPoint1: CGPoint(
                    x: controlPoint1X,
                    y: baseY + randomOffsets[index * 2]
                ),
                controlPoint2: CGPoint(
                    x: controlPoint2X,
                    y: baseY - randomOffsets[index * 2 + 1]
                ),
                progress: internalProgress
            )
        }
    }

}
