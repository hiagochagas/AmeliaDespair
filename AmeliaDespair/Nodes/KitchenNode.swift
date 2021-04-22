//
//  KitchenNode.swift
//  AmeliaDespair
//
//  Created by Felipe Santana on 22/04/21.
//  swiftlint:disable trailing_whitespace

import Foundation
import SpriteKit

class KitchenNode: SKNode {
    
    func addScenery(named imageName: String, at position: CGPoint, scaledTo scale: CGFloat = 1, hasCollision: Bool = true, zPosition: DrawingPlane = .middleground) {
        let scenery = SceneryEntity(imageName: "Kitchen/\(imageName)", hasCollision: hasCollision)
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
        
        addScenery(named: "Cupboard", at: CGPoint(x: 165, y: 579), hasCollision: false, zPosition: .foreground)
        addScenery(named: "Oven", at: CGPoint(x: -221, y: 530))
        addScenery(named: "RangeHood", at: CGPoint(x: -137, y: 582), hasCollision: false)
        addScenery(named: "SinkCeiling", at: CGPoint(x: 0, y: 604), hasCollision: false)
        addScenery(named: "Stove", at: CGPoint(x: -137, y: 484))
        addScenery(named: "Sink", at: CGPoint(x: 0, y: 486))
        addScenery(named: "Counter", at: CGPoint(x: 165, y: 484), zPosition: .beforeground)
        addScenery(named: "Toaster", at: CGPoint(x: 190, y: 510), hasCollision: false, zPosition: .foreground)
        addScenery(named: "CoffeeMachine", at: CGPoint(x: 220, y: 525), hasCollision: false)
        addScenery(named: "MainWorktop", at: CGPoint(x: 0, y: 15))
        addScenery(named: "Freezer", at: CGPoint(x: -220, y: 180))
        addScenery(named: "Fridge", at: CGPoint(x: -220, y: 58))
        addScenery(named: "WineCellar", at: CGPoint(x: -222, y: -40))
        addScenery(named: "LeftWorktop", at: CGPoint(x: -222, y: -180))
        addScenery(named: "Pantry", at: CGPoint(x: -170, y: -468))
        addScenery(named: "PotPlant", at: CGPoint(x: -240, y: -215), hasCollision: false, zPosition: .foreground)
        addScenery(named: "PotPlant", at: CGPoint(x: -240, y: -185), hasCollision: false, zPosition: .foreground)
        addScenery(named: "PotPlant", at: CGPoint(x: -240, y: -155), hasCollision: false, zPosition: .foreground)
        addScenery(named: "FruitPlate", at: CGPoint(x: -230, y: -30), hasCollision: false, zPosition: .foreground)
        addScenery(named: "KnifeKit", at: CGPoint(x: -20, y: 155), hasCollision: false, zPosition: .foreground)
        addScenery(named: "Plate", at: CGPoint(x: -20, y: 0), hasCollision: false, zPosition: .foreground)
        addScenery(named: "Plate", at: CGPoint(x: -65, y: -70), hasCollision: false, zPosition: .foreground)
        addScenery(named: "Plate", at: CGPoint(x: 55, y: -45), hasCollision: false, zPosition: .foreground)
        addScenery(named: "Plate", at: CGPoint(x: 45, y: -110), hasCollision: false, zPosition: .foreground)
        addScenery(named: "Bottle", at: CGPoint(x: -15, y: -70), hasCollision: false, zPosition: .foreground)
        addScenery(named: "Glass", at: CGPoint(x: 0, y: -100), hasCollision: false, zPosition: .foreground)
        addScenery(named: "Glass", at: CGPoint(x: 0, y: -50), hasCollision: false, zPosition: .foreground)
        addScenery(named: "Glass", at: CGPoint(x: -35, y: -50), hasCollision: false, zPosition: .foreground)
        addScenery(named: "Glass", at: CGPoint(x: 30, y: 0), hasCollision: false, zPosition: .foreground)
        addScenery(named: "Stool", at: CGPoint(x: 120, y: 200))
        addScenery(named: "Stool", at: CGPoint(x: 120, y: 110))
        addScenery(named: "Stool", at: CGPoint(x: 120, y: 20))
        addScenery(named: "Stool", at: CGPoint(x: 120, y: -70))
        addScenery(named: "Stool", at: CGPoint(x: 120, y: -160))
        addScenery(named: "Cabinet", at: CGPoint(x: 205, y: -380))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
