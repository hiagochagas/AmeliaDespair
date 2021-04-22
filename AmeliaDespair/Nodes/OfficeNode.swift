//
//  OfficeNode.swift
//  AmeliaDespair
//
//  Created by Rodrigo Matos Aguiar on 20/04/21.
//

import SpriteKit

class OfficeNode: SKNode {

    func addScenery(named imageName: String, at position: CGPoint, scaledTo scale: CGFloat = 1, hasCollision: Bool = true, zPosition: DrawingPlane = .middleground) {
        let scenery = SceneryEntity(imageName: "Office/\(imageName)", hasCollision: hasCollision)
        guard let scenerySprite = scenery.component(ofType: AnimatedSpriteComponent.self)?.spriteNode else {
            return
        }
        scenery.component(ofType: CollisionComponent.self)?.loadCollision(shape: .edgeLoop)
        scenerySprite.position = position
        scenerySprite.zPosition = zPosition.rawValue
        scenerySprite.setScale(scale)
        addChild(scenerySprite)
    }

    override init() {
        super.init()
        addScenery(named: "Sofa", at: CGPoint(x: 260, y: 120))
        addScenery(named: "PotPlant", at: CGPoint(x: 260, y: 300))
        addScenery(named: "Bookshelf", at: CGPoint(x: 290, y: -130))
        addScenery(named: "Mat", at: CGPoint(x: -100, y: 100), hasCollision: false)
        setupDesk()
    }

    func setupDesk() {
        let deskPosition = CGPoint(x: -200, y: -130)
        addScenery(named: "Desk", at: deskPosition)
        addScenery(named: "Computer", at: CGPoint(x: deskPosition.x + -65, y: deskPosition.y + 60), hasCollision: false, zPosition: .foreground)
        addScenery(named: "Keyboard", at: CGPoint(x: deskPosition.x + -65, y: deskPosition.y + 30), hasCollision: false, zPosition: .foreground)
        addScenery(named: "Chair1", at: CGPoint(x: deskPosition.x, y: deskPosition.y - 20), hasCollision: false, zPosition: .foreground)
        addScenery(named: "TrashBin", at: CGPoint(x: deskPosition.x + 70, y: deskPosition.y - 45), hasCollision: false, zPosition: .foreground)
        addScenery(named: "DeskBooks", at: CGPoint(x: deskPosition.x + 55, y: deskPosition.y + 30), hasCollision: false, zPosition: .foreground)
        addScenery(named: "Lighter", at: CGPoint(x: deskPosition.x + 85, y: deskPosition.y + 35), hasCollision: false, zPosition: .foreground)
        addScenery(named: "TableLamp", at: CGPoint(x: deskPosition.x + 65, y: deskPosition.y + 75), hasCollision: false, zPosition: .foreground)
        addScenery(named: "Ashtray", at: CGPoint(x: deskPosition.x + 35, y: deskPosition.y + 55), hasCollision: false, zPosition: .foreground)
        addScenery(named: "Chair2", at: CGPoint(x: deskPosition.x + 40, y: deskPosition.y + 90), zPosition: .beforeground)
        addScenery(named: "Chair3", at: CGPoint(x: deskPosition.x + -50, y: deskPosition.y + 90), zPosition: .beforeground)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
