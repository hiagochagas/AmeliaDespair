import SpriteKit

class BackgroundWallsNode: SKNode {

    func addInvisibleWall() {
        let wall = InvisibleWallEntity()
        guard let wallCollisionComponent = wall.component(ofType: CollisionComponent.self) else { return }
        wallCollisionComponent.loadCollision(physicsBody: SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: 100, height: 100)))
    }

    override init() {
        super.init()
        addInvisibleWall()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
