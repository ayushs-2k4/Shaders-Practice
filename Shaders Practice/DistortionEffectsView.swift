//
//  DistortionEffectsView.swift
//  Shaders Practice
//
//  Created by Ayush Singhal on 05/05/24.
//

import SwiftUI

struct DistortionEffectsView: View {
    @State private var start = Date.now
    @State private var progress: CGFloat = 0.0

    var body: some View {
        TimelineView(.animation) { timeline in
            let elapsedTime = start.distance(to: timeline.date)

            Image(systemName: "figure.walk.circle")
                .font(.system(size: 300))
                .foregroundStyle(.tint)
                .distortionEffect(ShaderLibrary.waveY(.float(elapsedTime)), maxSampleOffset: .init(width: 100, height: 100))

            Image(.flag)
                .resizable()
                .frame(width: 300, height: 200)
                .visualEffect { content, proxy in
                    content
                        .distortionEffect(
                            ShaderLibrary.relativeWave(
                                .float(elapsedTime),
                                .float2(proxy.size)
                            ),
                            maxSampleOffset: .init(width: 100, height: 100)
                        )
                }

            Image(.card)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                .padding(24)
                .onTapGesture {
                    withAnimation {
                        self.progress = 1 - self.progress
                    }
                }
                .visualEffect {
                    content,
                        _ in
                    let k = abs(elapsedTime.magnitude.rounded() - elapsedTime.magnitude)
                    
                    return content
                        .distortionEffect(
                            ShaderLibrary.dynamicIslandType(
                                .boundingRect,
//                                .float(self.progress)
                                .float(k)
                            ),
                            maxSampleOffset: .zero
                        )
                }
        }
    }
}

#Preview {
    DistortionEffectsView()
}
