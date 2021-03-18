//
//  ColisionComponent.swift
//  AmeliaDespair
//
//  Created by Hiago Chagas on 18/03/21.
//

import SpriteKit
import GameplayKit

class ColisionComponent: GKComponent {
    var physicsBody: SKPhysicsBody?

    var spriteNode: SKSpriteNode? {
        return entity?.component(ofType: AnimatedSpriteComponent.self)?.spriteNode
    }

    func loadCollision() {
        if let nodeSize = spriteNode?.size {
            physicsBody = SKPhysicsBody(rectangleOf: nodeSize)
            physicsBody?.affectedByGravity = false
            physicsBody?.allowsRotation = false
            spriteNode?.physicsBody = physicsBody
        } else {
            print("Unable to make a nodeSize out of this Sprite")
        }
    }

}
