//
//  ColisionComponentTests.swift
//  AmeliaDespairTests
//
//  Created by Hiago Chagas on 18/03/21.
//

import XCTest
import SpriteKit
@testable import AmeliaDespair

class ColisionComponentTests: XCTestCase {
    var player: PlayerEntity?
    var colisionComponent: ColisionComponent? {
        return ColisionComponent()
    }
    
    func test_loadColision_withLoadedSpriteNode_spriteNodeShouldntBeNil() {
        player = PlayerEntity()
        let component = player?.component(ofType: ColisionComponent.self)
        component?.loadCollision()
        XCTAssertNotNil(component?.spriteNode)
    }
    
    func test_loadColision_withoutLoadedSpriteNode_spriteNodeShouldBeNil() {
        colisionComponent?.loadCollision()
        XCTAssertNil(colisionComponent?.spriteNode)
    }
}
