//
//  PlayerEntity.swift
//  AmeliaDespair
//
//  Created by Rodrigo Matos Aguiar on 16/03/21.
//

import GameplayKit

class AnimatedSpriteComponent: GKComponent {

    var spriteNode: SKSpriteNode!
    var animationAtlas: SKTextureAtlas?

    var animationTextures: [SKTexture] {
        animationAtlas?.textureNames.sorted().compactMap { textureName in animationAtlas?.textureNamed(textureName) } ?? []
    }

    override init() {
        super.init()
        spriteNode = SKSpriteNode(color: .white, size: CGSize(width: 100, height: 100))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(imageName: String) {
        super.init()
        spriteNode = SKSpriteNode(imageNamed: imageName)
    }

    init(atlasName: String) {
        super.init()
        self.animationAtlas = SKTextureAtlas(named: atlasName)
        self.spriteNode = SKSpriteNode(imageNamed: animationAtlas!.textureNames.first!)
        self.spriteNode.texture = animationTextures.first!
    }

    func setAnimation(atlasName: String) {
            spriteNode.removeAllActions()

            self.animationAtlas = SKTextureAtlas(named: atlasName)
            self.spriteNode.texture = animationTextures.first!

            spriteNode.run(
                SKAction.repeatForever(
                    SKAction.animate(
                        with: animationTextures,
                        timePerFrame: 0.1,
                        resize: false,
                        restore: true
                    )
                ),
                withKey: atlasName
            )
        }
}
