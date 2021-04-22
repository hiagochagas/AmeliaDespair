// swiftlint:disable trailing_whitespace

import GameplayKit

class InvisibleWallEntity: GKEntity {

    override init() {
        super.init()
    }
    
    init(color: UIColor, size: CGSize) {
        super.init()
        self.addComponent(AnimatedSpriteComponent(color: color, size: size))
        self.addComponent(CollisionComponent())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
