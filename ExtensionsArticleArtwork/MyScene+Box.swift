// Nodes for MyScene

import SpriteKit
import SwiftUI

extension MyScene {
    class Box: SKShapeNode {
        let text: String
        var hasCollided: Bool = false
        let id = UUID()
        
        var bottomPoint: CGPoint {
            return CGPoint(
                x: .zero,
                y: (-self.frame.height / 2)
            )
        }
        
        // MARK:  Initializers
        
        init(text: String) {
            self.text = text
            super.init()
            defineBoxNode()
            addLabelNode()
            addPhysics()
        }
        
        init(text: String, color: Color) {
            self.text = text
            super.init()
            defineBoxNode(color)
            addLabelNode()
            addPhysics()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Methods
        
        private func defineBoxNode(_ color: Color = .red) {
            let width: CGFloat = 300
            let height: CGFloat = 75
            let x: CGFloat = -(width / 2)
            let y: CGFloat = -(height / 2)
            let cornerRadius: CGFloat = 20
            let rect: CGRect = .init(x: x, y: y, width: width, height: height)
            let path: CGPath = .init(roundedRect: rect, cornerWidth: cornerRadius, cornerHeight: cornerRadius, transform: nil)
            
            self.path = path
            #if os(macOS)
            self.fillColor = NSColor(color)
            #elseif os(iOS)
            self.fillColor = UIColor(color)
            #endif
            self.lineWidth = 0
            self.strokeColor = .clear
            self.name = PhysicsBody.box.name
            
            addInnerBox()
            
            
            func addInnerBox() {
                let lineWidth: CGFloat = 6.0
                let innerWidth = width - lineWidth
                let innerHeight = height - lineWidth
                let innerX = -(innerWidth / 2)
                let innerY = -(innerHeight / 2)
                let innerCornerRadius = cornerRadius - (lineWidth / 2)
                let innerBoxRect = CGRect(x: innerX, y: innerY, width: innerWidth, height: innerHeight)
                let innerBoxPath = CGPath(roundedRect: innerBoxRect, cornerWidth: innerCornerRadius, cornerHeight: innerCornerRadius, transform: nil)
                let innerBox = SKShapeNode(path: innerBoxPath)
                innerBox.fillColor = .clear
                
                #if os(macOS)
                innerBox.strokeColor = NSColor(white: 1, alpha: 0.2)
                #elseif os(iOS)
                innerBox.strokeColor = UIColor(white: 1, alpha: 0.2)
                #endif
                
                innerBox.lineWidth = 8
                
                self.addChild(innerBox)
            }
        }
        
        private func addLabelNode() {
            let label = SKLabelNode(text: text)
            let fontName = "Helvetica-bold"
            label.fontName = fontName
            label.fontSize = 16
            label.position.y -= label.frame.height / 3
            
            addChild(label)
        }
        
        private func addPhysics() {
            let boxPhysicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
            boxPhysicsBody.affectedByGravity = true
            boxPhysicsBody.mass = 1
            boxPhysicsBody.categoryBitMask = .boxCategoryBitMask
            
            boxPhysicsBody.contactTestBitMask = .boxCategoryBitMask
            
            self.physicsBody = boxPhysicsBody
        }
    }
}
