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
    var movementComponent: MovementComponent? {
        return player?.component(ofType: MovementComponent.self)
    }
    
    override func setUp() {
        player = PlayerEntity()
        movementComponent?.spriteNode?.position = CGPoint(x: 0, y: 0)
    }
    
    func test_move_whenVelocityIsProvided_shouldMoveSpriteNode() {
        let velocity = CGPoint(x: 50, y: 50)
        movementComponent?.velocity = velocity
        XCTAssertNotNil(movementComponent)
        guard let oldPosition = movementComponent?.spriteNode?.position else {
            XCTFail("Couldn't get the sprite node's old position")
            return
        }
        movementComponent?.move()
        guard let newPosition = movementComponent?.spriteNode?.position else {
            XCTFail("Couldn't get the sprite node's new position")
            return
        }
        guard let velocityMultiplier = movementComponent?.velocityMultiplier else {
            XCTFail("Couldn't get the move component's velocity multiplier")
            return
        }
        let expectedPosition = CGPoint(x: (oldPosition.x + velocity.x) * velocityMultiplier, y: (oldPosition.y + velocity.y) * velocityMultiplier)
        XCTAssertEqual(newPosition, expectedPosition)
    }
    
}
