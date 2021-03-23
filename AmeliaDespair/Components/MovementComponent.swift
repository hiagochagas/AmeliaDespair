//
//  MovementComponent.swift
//  AmeliaDespair
//
//  Created by Rodrigo Matos Aguiar on 16/03/21.
//

import GameplayKit

class MovementComponent: GKComponent {
    var velocity = CGPoint(x: 0, y: 0)
    let velocityMultiplier: CGFloat = 0.1

    var spriteNode: SKSpriteNode? {
        self.entity?.component(ofType: AnimatedSpriteComponent.self)?.spriteNode
    }

    func move() {
        spriteNode?.position.x += velocity.x * velocityMultiplier
        spriteNode?.position.y += velocity.y * velocityMultiplier
    }

}
