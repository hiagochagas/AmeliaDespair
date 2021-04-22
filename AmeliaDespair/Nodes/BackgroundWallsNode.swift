import SpriteKit

class BackgroundWallsNode: SKNode {

    func addInvisibleWall(size: CGSize, position: CGPoint) {
        let wall = InvisibleWallEntity(color: .clear, size: size)
        guard let wallCollisionComponent = wall.component(ofType: CollisionComponent.self) else { return }
        guard let wallSpriteNode = wall.component(ofType: AnimatedSpriteComponent.self)?.spriteNode else { return }
        wallCollisionComponent.loadCollision(shape: .edgeLoop)
        wallSpriteNode.position = position
        wallSpriteNode.zPosition = DrawingPlane.hud.rawValue
        addChild(wallSpriteNode)
    }

    override init() {
        super.init()
        addInvisibleWall(size: CGSize(width: 1072, height: 12), position: CGPoint(x: 44, y: 531))
        addInvisibleWall(size: CGSize(width: 12, height: 1046), position: CGPoint(x: 586, y: 14))
        addInvisibleWall(size: CGSize(width: 51, height: 12), position: CGPoint(x: 421, y: -513))
        addInvisibleWall(size: CGSize(width: 467, height: 12), position: CGPoint(x: 770, y: -513))
        addInvisibleWall(size: CGSize(width: 12, height: 1436), position: CGPoint(x: 388, y: -329))
        addInvisibleWall(size: CGSize(width: 622, height: 12), position: CGPoint(x: 693, y: -1053))
        addInvisibleWall(size: CGSize(width: 12, height: 552), position: CGPoint(x: 1010, y: -783))
        addInvisibleWall(size: CGSize(width: 1388, height: 12), position: CGPoint(x: -311, y: -496))
        addInvisibleWall(size: CGSize(width: 12, height: 1053), position: CGPoint(x: -1011, y: 25))
        addInvisibleWall(size: CGSize(width: 12, height: 596), position: CGPoint(x: -498, y: 239))
        addInvisibleWall(size: CGSize(width: 12, height: 269), position: CGPoint(x: -498, y: -355))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
