//
//  ContentView.swift
//  Shaders Practice
//
//  Created by Ayush Singhal on 05/05/24.
//

@Observable
class Router {
    var path: [Int] = []
}

import SwiftUI

struct ContentView: View {
    @State private var router: Router = .init()

    var body: some View {
//        Text("Hello World!")
//        LayerEffectsView()

        NavigationStack(path: Bindable(router).path) {
            VStack {
                Button("Go to color Effects View") {
                    router.path.append(1)
                }
                .padding()
                
                Button("Go to Distortion Effects View") {
                    router.path.append(2)
                }
                .padding()
                
                Button("Go to Layer Effects View") {
                    router.path.append(3)
                }
                .padding()
            }
            .navigationDestination(for: Int.self) { val in
                if val == 1 {
                    ColorEffectsView()
                }

                if val == 2 {
                    DistortionEffectsView()
                }

                if val == 3 {
                    LayerEffectsView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
