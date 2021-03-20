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
        self.addComponent(AnimatedSpriteComponent(imageName: "Amelia"))
        self.addComponent(MovementComponent())
        self.addComponent(CollisionComponent())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
