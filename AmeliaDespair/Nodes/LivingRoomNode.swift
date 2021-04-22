//
//  LivingRoomNode.swift
//  AmeliaDespair
//
//  Created by Rodrigo Matos Aguiar on 22/04/21.
//

import SpriteKit

class LivingRoomNode: SKNode {

    func addScenery(named imageName: String, at position: CGPoint, scaledTo scale: CGFloat = 1, hasCollision: Bool = true, zPosition: DrawingPlane = .middleground, inverted: Bool = false) {
        let scenery = SceneryEntity(imageName: imageName, hasCollision: hasCollision)
        guard let scenerySprite = scenery.component(ofType: AnimatedSpriteComponent.self)?.spriteNode else {
            return
        }
        scenery.component(ofType: CollisionComponent.self)?.loadCollision(shape: .edgeLoop)
        scenerySprite.position = position
        scenerySprite.zPosition = zPosition.rawValue
        scenerySprite.setScale(scale)
        if inverted {
            scenerySprite.xScale = -1
        }
        addChild(scenerySprite)
    }

    override init() {
        super.init()

        addScenery(named: "LivingRoom/Piano", at: CGPoint(x: -350, y: -350), zPosition: .middleground)

        addScenery(named: "LivingRoom/MainTable", at: CGPoint(x: 191, y: -244), zPosition: .middleground)
        addScenery(named: "LivingRoom/Chair", at: CGPoint(x: 108, y: -86), zPosition: .middleground)
        addScenery(named: "LivingRoom/Chair", at: CGPoint(x: 273, y: -86), zPosition: .middleground, inverted: true)
        addScenery(named: "LivingRoom/Chair", at: CGPoint(x: 86, y: -164), zPosition: .middleground)
        addScenery(named: "LivingRoom/Chair", at: CGPoint(x: 295, y: -164), zPosition: .middleground, inverted: true)
        addScenery(named: "LivingRoom/Chair", at: CGPoint(x: 86, y: -252), zPosition: .middleground)
        addScenery(named: "LivingRoom/Chair", at: CGPoint(x: 295, y: -252), zPosition: .middleground, inverted: true)
        addScenery(named: "LivingRoom/Chair", at: CGPoint(x: 100, y: -352), zPosition: .middleground)
        addScenery(named: "LivingRoom/Chair", at: CGPoint(x: 283, y: -352), zPosition: .middleground, inverted: true)

        addScenery(named: "LivingRoom/TV", at: CGPoint(x: 6, y: 625), hasCollision: false, zPosition: .middleground)
        addScenery(named: "LivingRoom/FurniturePiece", at: CGPoint(x: 6, y: 523), zPosition: .middleground)
        addScenery(named: "LivingRoom/Devices", at: CGPoint(x: -98, y: 537), hasCollision: false, zPosition: .foreground)
        addScenery(named: "LivingRoom/Mat", at: CGPoint(x: 6, y: 321), hasCollision: false, zPosition: .middleground)
        addScenery(named: "LivingRoom/MiddleTable", at: CGPoint(x: 6, y: 328), zPosition: .foreground)
        addScenery(named: "Kitchen/PotPlant", at: CGPoint(x: 5, y: 328), hasCollision: false, zPosition: .afterground)
        addScenery(named: "Office/Sofa", at: CGPoint(x: -215, y: 321), zPosition: .foreground, inverted: true)
        addScenery(named: "Office/Sofa", at: CGPoint(x: 226, y: 321), zPosition: .foreground)
        addScenery(named: "LivingRoom/Sofa", at: CGPoint(x: 1, y: 158), zPosition: .foreground)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
