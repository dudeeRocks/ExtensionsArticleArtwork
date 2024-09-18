//
//  MyScene.swift
//  ExtensionsArticleArtwork
//
//  Created by David Katsman on 17/09/2024.
//

import SpriteKit
import SwiftUI

class MyScene: SKScene {
    
    private let floor = Floor()
    
    private var lastUpdate: TimeInterval = 0.0
    private var nextBoxHue: CGFloat = 0.0
    private var nextExtension: Int = 0
    private var isAutoReseting: Bool = false
    
    private let baseClassText: String = "ViewController"
    private let extensionsText: [String] = [
        "+Layout",
        "+Actions",
        "+Navigation",
        "+Location",
        "+Error",
        "+UITableViewDelegate",
        "+UITextFieldDelegate",
        "+UIPickerViewDelegate",
        "+MKMapViewDelegate",
    ]
    
    var collidedBoxes: [Box] = []
    
    override func didMove(to view: SKView) {
        scene?.size = view.frame.size
        setUpCamera()
        setPhysicsContactDelegate()
        addChild(floor)
        floor.position.x = frame.width / 2
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard nextExtension < extensionsText.count else {
            autoReset()
            return
        }
        
        if lastUpdate == 0.0 {
            addBox(withText: baseClassText)
            lastUpdate = currentTime
            nextBoxHue += 0.1
        } else if currentTime - lastUpdate >= 1.0 {
            addBox(withText: baseClassText + extensionsText[nextExtension])
            lastUpdate = currentTime
            nextBoxHue += 0.1
            nextExtension += 1
        }
    }
    
    private func addBox(withText text: String) {
        guard let scene = scene else { return }
        let color = Color(hue: nextBoxHue, saturation: 1.0, brightness: 0.9)
        let box = Box(text: text, color: color)
        box.position.x += self.frame.width / 2
        box.position.y += self.frame.height + box.frame.height
        
        #if os(macOS)
        box.setScale(1.35)
        #endif
        
        scene.addChild(box)
    }
    
    private func setUpCamera() {
        let camera = SKCameraNode()
        let cameraPosition = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        self.camera = camera
        self.camera?.position = cameraPosition
        self.addChild(camera)
    }
    
    private func autoReset() {
        guard !isAutoReseting else { return }
        
        isAutoReseting = true
        
        floor.run(.sequence([
            .wait(forDuration: 1.0),
            .fadeOut(withDuration: 0.5),
            .removeFromParent(),
        ])) {
            self.physicsWorld.gravity.dy = -2
        }
        
        run(.sequence([
            .wait(forDuration: 5.0),
        ])) {
            self.physicsWorld.gravity.dy = -9.8
            self.resetScene()
            self.isAutoReseting = false
        }
    }
    
    func resetScene() {
        removeAllChildren()
        nextBoxHue = 0.0
        lastUpdate = 0.0
        nextExtension = 0
        collidedBoxes.removeAll()
        addChild(floor)
    }
}

#Preview {
    ContentView()
}
