//
//  AmeliaDespairTests.swift
//  AmeliaDespairTests
//
//  Created by Rodrigo Matos Aguiar on 17/03/21.
//

import XCTest
@testable import AmeliaDespair

class MoveComponentTests: XCTestCase {
    
    var player: PlayerEntity?
    var moveComponent: MoveComponent? {
        return player?.component(ofType: MoveComponent.self)
    }
    
    override func setUp() {
        player = PlayerEntity()
        moveComponent?.spriteNode?.position = CGPoint(x: 0, y: 0)
    }
    
    func test_move_whenVelocityIsProvided_shouldMoveSpriteNode() {
        let velocity = CGPoint(x: 50, y: 50)
        moveComponent?.velocity = velocity
        XCTAssertNotNil(moveComponent)
        guard let oldPosition = moveComponent?.spriteNode?.position else {
            XCTFail("Couldn't get the sprite node's old position")
            return
        }
        moveComponent?.move()
        guard let newPosition = moveComponent?.spriteNode?.position else {
            XCTFail("Couldn't get the sprite node's new position")
            return
        }
        guard let velocityMultiplier = moveComponent?.velocityMultiplier else {
            XCTFail("Couldn't get the move component's velocity multiplier")
            return
        }
        let expectedPosition = CGPoint(x: (oldPosition.x + velocity.x) * velocityMultiplier, y: (oldPosition.y + velocity.y) * velocityMultiplier)
        XCTAssertEqual(newPosition, expectedPosition)
    }
    
}
