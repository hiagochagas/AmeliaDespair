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
        self.spriteNode = SKSpriteNode(color: .white, size: CGSize(width: 100, height: 100))
    }

    required init?(coder: NSCoder) {
        return nil
    }

    init(imageName: String) {
        super.init()
        spriteNode = SKSpriteNode(imageNamed: imageName)
    }

    init(atlasName: String, entity: GKEntity) {
        super.init()
        self.animationAtlas = SKTextureAtlas(named: atlasName)
        self.spriteNode = SKSpriteNode(imageNamed: animationAtlas!.textureNames.first!)
        self.spriteNode.texture = animationTextures.first!
        self.spriteNode.entity = entity
    }

    func setAnimation(atlasName: String, textures: SKTextureAtlas? = nil) {
            spriteNode.removeAllActions()
            if let textures = textures {
                self.animationAtlas = textures
            } else {
                self.animationAtlas = SKTextureAtlas(named: atlasName)
            }
            self.spriteNode.texture = animationTextures.first!
            spriteNode.run(
                SKAction.repeatForever(
                    SKAction.animate(
                        with: animationTextures,
                        timePerFrame: 0.15,
                        resize: true,
                        restore: true
                    )
                ),
                withKey: atlasName
            )
        }
}
