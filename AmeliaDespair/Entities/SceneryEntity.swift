import GameplayKit

class SceneryEntity: GKEntity {

    init(imageName: String, hasCollision: Bool = true) {
        super.init()
        self.addComponent(AnimatedSpriteComponent(imageName: imageName))
        if hasCollision {
            self.addComponent(CollisionComponent())
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
