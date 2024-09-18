//
//  ExtensionsArticleArtworkApp.swift
//  ExtensionsArticleArtwork
//
//  Created by David Katsman on 17/09/2024.
//

import SwiftUI

@main
struct ExtensionsArticleArtworkApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .background(Color(hue: 0, saturation: 0, brightness: 0.2))
            #if os(macOS)
                .frame(width: 1080, height: 1080)
            #endif
        }
    }
}
