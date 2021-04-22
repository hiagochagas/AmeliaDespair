//
//  HallwayNode.swift
//  AmeliaDespair
//
//  Created by Felipe Santana on 21/04/21.
//  swiftlint:disable trailing_whitespace

import Foundation
import SpriteKit

class HallwayNode: SKNode {
    
    func addScenery(named imageName: String, at position: CGPoint, scaledTo scale: CGFloat = 1, hasCollision: Bool = true, zPosition: DrawingPlane = .middleground) {
        let scenery = SceneryEntity(imageName: "Hallway/\(imageName)", hasCollision: hasCollision)
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
        
        addScenery(named: "Sideboard", at: CGPoint(x: 60, y: 0))
        addScenery(named: "TableLamp", at: CGPoint(x: 60, y: 40), hasCollision: false, zPosition: .foreground)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
