// Floor

import SpriteKit

extension MyScene {
    class Floor: SKShapeNode {
        
        override init() {
            super.init()
            defineFloor()
            addPhysics()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func defineFloor() {
            let x = 0.0
            let y = 0.0
            
            let width = 1000.0
            let heigh = 10.0
            
            let rect = CGRect(x: x, y: y, width: width, height: heigh)
            
            self.path = CGPath(rect: rect, transform: nil)
            
            self.fillColor = .clear
            self.lineWidth = 0
            self.strokeColor = .clear
        }
        
        private func addPhysics() {
            let physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
            physicsBody.categoryBitMask = .sceneCategoryBitMask
            physicsBody.collisionBitMask = .boxCategoryBitMask
            physicsBody.contactTestBitMask = .boxCategoryBitMask
            physicsBody.affectedByGravity = false
            physicsBody.isDynamic = false
            
            self.physicsBody = physicsBody
        }
    }
}
