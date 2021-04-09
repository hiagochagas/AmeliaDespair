//
//  PlayerEntity.swift
//  AmeliaDespair
//
//  Created by Rodrigo Matos Aguiar on 16/03/21.
//

import GameplayKit

class PlayerEntity: GKEntity {

    override init() {
        super.init()
        self.addComponent(AnimatedSpriteComponent(atlasName: PlayerAtlasName.walkDown.rawValue, entity: self))
        self.addComponent(MovementComponent())
        self.addComponent(CollisionComponent())
        self.addComponent(PlayerControlComponent(states: [IdleState(self), WalkState(self)]))
        self.addComponent(SoundComponent(audioTypeToStringDictionary: [.walking:"playerWalking.wav", .colliding:"bump.wav"]))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
