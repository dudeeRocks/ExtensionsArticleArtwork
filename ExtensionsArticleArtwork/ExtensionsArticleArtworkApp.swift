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
            #if os(macOS)
                .frame(width: 1200, height: 800)
            #endif
        }
    }
}
