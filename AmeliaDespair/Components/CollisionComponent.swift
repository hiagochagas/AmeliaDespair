//
//  CollisionComponent.swift
//  AmeliaDespair
//
//  Created by Hiago Chagas on 18/03/21.
//

import SpriteKit
import GameplayKit

enum CollisionShape {
    case rectangle, edgeLoop, enemyRectangle
}

class CollisionComponent: GKComponent {
    var physicsBody: SKPhysicsBody?

    var spriteNode: SKSpriteNode? {
        return entity?.component(ofType: AnimatedSpriteComponent.self)?.spriteNode
    }

    /// Loads the collision and makes it ready for use.
    ///
    /// You need to call this method when using CollisionComponent, preferably before setting the sprite node's position.
    /// - Parameter shape: The collision shape of the collision component.
    func loadCollision(shape: CollisionShape = .rectangle) {
        guard let spriteNode = spriteNode else {
            print("Unable to get spriteNode of AnimatedSpriteComponent")
            return
        }
        switch shape {
        case .rectangle:
            physicsBody = SKPhysicsBody(rectangleOf: spriteNode.size)
        case .edgeLoop:
            physicsBody = SKPhysicsBody(edgeLoopFrom: spriteNode.frame)
        case .enemyRectangle:
            physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: spriteNode.size.width, height: spriteNode.size.height * 0.1))
        }
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        // for some reason, the contactTestBitMask needs to get a value for the detection of collision 
        physicsBody?.contactTestBitMask = 2
        spriteNode.physicsBody = physicsBody
    }

    /// Loads the collision and makes it ready for use.
    ///
    /// You need to call this method when using CollisionComponent, preferably before setting the sprite node's position.
    /// - Parameter physicsBody: The physics body of the collision component.
    func loadCollision(physicsBody: SKPhysicsBody) {
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        // for some reason, the contactTestBitMask needs to get a value for the detection of collision
        physicsBody.contactTestBitMask = 2
        spriteNode?.physicsBody = physicsBody
    }

}
