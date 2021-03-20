//
//  PlayerEntity.swift
//  AmeliaDespair
//
//  Created by Rodrigo Matos Aguiar on 16/03/21.
//

import GameplayKit

class AnimatedSpriteComponent: GKComponent {
    var spriteNode: SKSpriteNode!

    override init() {
        super.init()
        spriteNode = SKSpriteNode(color: .white, size: CGSize(width: 100, height: 100))
    }

    init(imageName: String) {
        super.init()
        spriteNode = SKSpriteNode(imageNamed: imageName)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
