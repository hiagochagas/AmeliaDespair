//
//  BackgroundEntity.swift
//  AmeliaDespair
//
//  Created by Rodrigo Matos Aguiar on 19/03/21.
//

import GameplayKit

class BackgroundEntity: GKEntity {

    override init() {
        super.init()
        self.addComponent(AnimatedSpriteComponent(imageName: "AmeliaBackground.jpg"))
        self.addComponent(CollisionComponent())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
