//
//  EnemyEntity.swift
//  AmeliaDespair
//
//  Created by Hiago Chagas on 20/04/21.
//

import GameplayKit

class EnemyEntity: GKEntity {
    override init() {
        super.init()
        self.addComponent(AnimatedSpriteComponent(atlasName: EnemyAtlasName.walkDown.rawValue, entity: self))
        self.addComponent(MovementComponent())
        self.addComponent(CollisionComponent())
        self.addComponent(EnemyControlComponent(states: [IdleState(self), EnemyWalkState(self)]))
        self.addComponent(SoundComponent(audioTypeToStringDictionary: [.colliding:"bump.wav"]))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
