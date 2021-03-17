//
//  PlayerEntity.swift
//  AmeliaDespair
//
//  Created by Rodrigo Matos Aguiar on 16/03/21.
//

import GameplayKit

class MoveComponent: GKComponent {
    var velocity: CGPoint?

    var spriteNode: SKSpriteNode? {
        self.entity?.component(ofType: AnimatedSpriteComponent.self)?.spriteNode
    }

    func setVelocity(velocity: CGPoint) {
        self.velocity = velocity
    }

    private func move() {
        if let velocity = velocity {
            spriteNode?.position.x += velocity.x * 0.1
            spriteNode?.position.y += velocity.y * 0.1
        }
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        move()
    }

}
