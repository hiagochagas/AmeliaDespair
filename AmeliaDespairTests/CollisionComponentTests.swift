//
//  CollisionComponentTests.swift
//  AmeliaDespairTests
//
//  Created by Hiago Chagas on 18/03/21.
//

import XCTest
import SpriteKit
@testable import AmeliaDespair

class CollisionComponentTests: XCTestCase {
    var player: PlayerEntity?
    var collisionComponent: CollisionComponent? {
        return CollisionComponent()
    }
    
    func test_loadCollision_withLoadedSpriteNode_spriteNodeShouldntBeNil() {
        player = PlayerEntity()
        let component = player?.component(ofType: CollisionComponent.self)
        component?.loadCollision()
        XCTAssertNotNil(component?.spriteNode)
    }
    
    func test_loadCollision_withoutLoadedSpriteNode_spriteNodeShouldBeNil() {
        collisionComponent?.loadCollision()
        XCTAssertNil(collisionComponent?.spriteNode)
    }
}
