// MyScene physics logic

import SpriteKit

extension MyScene  {
    
    func addScenePhysics() {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.categoryBitMask = .sceneCategoryBitMask
        self.physicsBody?.collisionBitMask = .boxCategoryBitMask
        self.physicsBody?.contactTestBitMask = .boxCategoryBitMask
        self.physicsWorld.contactDelegate = self
    }
}

extension MyScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let box: Box? = contact.bodyA.node as? Box ?? contact.bodyB.node as? Box
        
        if let box = box {
            if !collidedBoxes.contains(where: { $0.id == box.id }) {
                addEmitters(for: box)
                collidedBoxes.append(box)
            }
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
