//
//  ColorEffectsView.swift
//  Shaders Practice
//
//  Created by Ayush Singhal on 05/05/24.
//

import SwiftUI

struct ColorEffectsView: View {
    @State private var start = Date.now

    var body: some View {
        ScrollView {
            ImageView()
                .colorEffect(ShaderLibrary.passthrough())

            Image(systemName: "figure.walk.circle")
                .font(.system(size: 300))
                .foregroundStyle(.tint)
                .colorEffect(ShaderLibrary.recolor())

            ImageView()
                .colorEffect(ShaderLibrary.invertAlpha())

            ImageView()
                .colorEffect(ShaderLibrary.gradient())

            TimelineView(.animation) { timeline in
                let elapsedTime = start.distance(to: timeline.date)

                ImageView()
                    .colorEffect(ShaderLibrary.animatedSilverEffect(.float(elapsedTime)))

                ImageView()
                    .colorEffect(ShaderLibrary.animatedGradient(.float(elapsedTime)))
            }
        }
    }
}

struct ImageView: View {
    var body: some View {
        Image(systemName: "figure.walk.circle")
            .font(.system(size: 300))
            .foregroundStyle(.tint)
    }
}

#Preview {
    ColorEffectsView()
}
