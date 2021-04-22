import GameplayKit

class InvisibleWallEntity: GKEntity {

    override init() {
        super.init()
        self.addComponent(AnimatedSpriteComponent())
        self.addComponent(CollisionComponent())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
