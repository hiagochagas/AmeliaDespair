//
//  IdleState.swift
//  AmeliaDespair
//
//  Created by Rodrigo Matos Aguiar on 22/03/21.
//

import GameplayKit

class IdleState: GKState {
    var entity: GKEntity

    var animatedSpriteComponent: AnimatedSpriteComponent? {
        self.entity.component(ofType: AnimatedSpriteComponent.self)
    }

    var walkComponent: MovementComponent? {
        self.entity.component(ofType: MovementComponent.self)
    }

    var soundComponent: SoundComponent? {
        self.entity.component(ofType: SoundComponent.self)
    }

    init(_ entity: GKEntity) {
        self.entity = entity
        super.init()
    }

    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        soundComponent?.stopAudio(audioType: .walking)
        animatedSpriteComponent?.spriteNode.removeAllActions()
        animatedSpriteComponent?.spriteNode.run(SKAction.setTexture((animatedSpriteComponent?.animationTextures.first)!, resize: true))
    }
}
