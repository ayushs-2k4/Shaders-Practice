//
//  LayerEffectsView.swift
//  Shaders Practice
//
//  Created by Ayush Singhal on 05/05/24.
//

import SwiftUI

struct LayerEffectsView: View {
    @State private var touch = CGPoint.zero

    var body: some View {
        ScrollView {
            Image(systemName: "figure.walk.circle")
                .font(.system(size: 300))
                .foregroundStyle(.tint)
                .visualEffect {
                    content,
                        proxy in
                    content
                        .layerEffect(
                            ShaderLibrary.warpingLoupe(
                                .float2(proxy.size),
                                //                            .float2(UIScreen.main.bounds.size),
                                .float2(touch)
                            ),
                            maxSampleOffset: .zero
                        )
                }
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged {
                            touch = $0.location
                        }
                )

            Image(.hammerthrowWhite)
                .visualEffect {
                    content,
                        proxy in
                    content
                        .layerEffect(
                            ShaderLibrary.warpingLoupe(
                                .float2(proxy.size),
                                //                            .float2(UIScreen.main.bounds.size),
                                .float2(touch)
                            ),
                            maxSampleOffset: .zero
                        )
                }
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged {
                            touch = $0.location
                        }
                )
        }
    }
}

#Preview {
    LayerEffectsView()
}
