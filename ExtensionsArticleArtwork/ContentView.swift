//
//  ContentView.swift
//  ExtensionsArticleArtwork
//
//  Created by David Katsman on 17/09/2024.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    @State var scene = MyScene()
    
    var body: some View {
        SpriteView(scene: scene, debugOptions: [])
            .onTapGesture {
                scene.resetScene()
                print("tapped")
            }
            .onKeyPress(.space) {
                scene.resetScene()
                return .handled
            }
    }
}

#Preview {
    ContentView()
}
