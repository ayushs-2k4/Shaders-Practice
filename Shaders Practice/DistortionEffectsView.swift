//
//  DistortionEffectsView.swift
//  Shaders Practice
//
//  Created by Ayush Singhal on 05/05/24.
//

import SwiftUI

struct DistortionEffectsView: View {
    @State private var start = Date.now

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
        }
    }
}

#Preview {
    DistortionEffectsView()
}
