//
//  PlayerEntity.swift
//  AmeliaDespair
//
//  Created by Rodrigo Matos Aguiar on 16/03/21.
// swiftlint:disable trailing_whitespace

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
        self.spriteNode.lightingBitMask = 0b0001
    }
    
    init(color: UIColor, size: CGSize) {
        super.init()
        self.spriteNode = SKSpriteNode(color: color, size: size)
        self.spriteNode.lightingBitMask = 0b0001
    }

    required init?(coder: NSCoder) {
        return nil
    }

    init(imageName: String) {
        super.init()
        self.spriteNode = SKSpriteNode(imageNamed: imageName)
        self.spriteNode.lightingBitMask = 0b0001
    }

    init(atlasName: String, entity: GKEntity) {
        super.init()
        self.animationAtlas = SKTextureAtlas(named: atlasName)
        self.spriteNode = SKSpriteNode(imageNamed: animationAtlas!.textureNames.first!)
        self.spriteNode.texture = animationTextures.first!
        self.spriteNode.entity = entity
        self.spriteNode.lightingBitMask = 0b0001
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
