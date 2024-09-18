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
            let rect: CGRect = .init(x: x, y: y, width: width, height: height)
            let path: CGPath = .init(roundedRect: rect, cornerWidth: 20, cornerHeight: 20, transform: nil)
            
            self.path = path
            #if os(macOS)
            self.fillColor = NSColor(color)
            #elseif os(iOS)
            self.fillColor = UIColor(color)
            #endif
            self.lineWidth = 0
            self.strokeColor = .clear
            self.name = PhysicsBody.box.name
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
