// Emitter logic for my scene

import SpriteKit

extension MyScene {
    enum BoxSide { case left, right}
    
    func addEmitters(for box: Box) {
        guard 
            let leftEmitter = newDustEmmiter(),
            let rightEmitter = newDustEmmiter()
        else {
            print("X")
            return
        }
        
        leftEmitter.xScale = -1
        leftEmitter.position = box.bottomPoint
        rightEmitter.position = box.bottomPoint
        
        let dustAnimation = SKAction.sequence([
            .wait(forDuration: 1),
            .removeFromParent()])
        
        box.addChild(leftEmitter)
        box.addChild(rightEmitter)
        
        leftEmitter.run(dustAnimation)
        rightEmitter.run(dustAnimation)
    }
    
    private func newDustEmmiter() -> SKEmitterNode? {
        return SKEmitterNode(fileNamed: "DustEffect.sks")
    }
    
    func addEmitters(at point: CGPoint) {
        guard
            let leftEmitter = newDustEmmiter(),
            let rightEmitter = newDustEmmiter()
        else {
            return
        }
        
        leftEmitter.xScale = -1
        leftEmitter.position = point
        rightEmitter.position = point
        
        let dustAnimation = SKAction.sequence([
            .wait(forDuration: 0.5),
            .removeFromParent()])
        
        addChild(leftEmitter)
        addChild(rightEmitter)
        
        leftEmitter.run(dustAnimation)
        rightEmitter.run(dustAnimation)
    }
}
