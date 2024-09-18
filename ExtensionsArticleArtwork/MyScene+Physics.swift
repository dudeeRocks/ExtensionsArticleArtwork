// MyScene physics logic

import SpriteKit

extension MyScene  {
    
    func addScenePhysics() {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.categoryBitMask = .sceneCategoryBitMask
        self.physicsBody?.collisionBitMask = .boxCategoryBitMask
        self.physicsBody?.contactTestBitMask = .boxCategoryBitMask
    }
}

extension MyScene: SKPhysicsContactDelegate {
    
    func setPhysicsContactDelegate() {
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity.dy = -9.8
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if let box = contact.bodyA.node as? Box, !collidedBoxes.contains(where: { $0.id == box.id }) {
            addEmitters(for: box)
            collidedBoxes.append(box)
        } else if let otherBox = contact.bodyB.node as? Box, !collidedBoxes.contains(where: { $0.id == otherBox.id }) {
            addEmitters(for: otherBox)
            collidedBoxes.append(otherBox)
        }
    }
}

extension MyScene {
    enum PhysicsBody {
        case scene, box
        
        var name: String {
            switch self {
            case .scene:
                return "Scene"
            case .box:
                return "Box"
            }
        }
        
        var categoryBitMask: UInt32 {
            switch self {
            case .scene:
                return 1
            case .box:
                return 2
            }
        }
    }
}

extension UInt32 {
    static let sceneCategoryBitMask = MyScene.PhysicsBody.scene.categoryBitMask
    static let boxCategoryBitMask = MyScene.PhysicsBody.box.categoryBitMask
}
