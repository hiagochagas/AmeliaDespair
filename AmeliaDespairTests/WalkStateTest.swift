//
//  WalkStateTest.swift
//  AmeliaDespairTests
//
//  Created by Vitor Bryan on 20/04/21.
//

import XCTest
@testable import AmeliaDespair
import GameplayKit

class WalkStateTest: XCTestCase {
    
    var entity: GKEntity?
    
    var walkState: WalkState? {
        return WalkState(entity!)
    }
    
    override func setUp() {
        entity = PlayerEntity()
    }
    
    func test_setAudio() {
        let sound = entity?.component(ofType: SoundComponent.self)
        sound?.playAudioRepeatedly(audioType: .walking)
        let playing = sound?.audioIsPlaying
        XCTAssertTrue((playing != nil) == true)
    }
    
    func test_setAnimation() {
        let animation = entity?.component(ofType: AnimatedSpriteComponent.self)
        let up: ()? = animation?.setAnimation(atlasName: PlayerAtlasName.walkUp.rawValue)
        let down: ()? = animation?.setAnimation(atlasName: PlayerAtlasName.walkDown.rawValue)
        let left: ()? = animation?.setAnimation(atlasName: PlayerAtlasName.walkLeft.rawValue)
        let right: ()? = animation?.setAnimation(atlasName: PlayerAtlasName.walkRight.rawValue)
        XCTAssertTrue((up != nil) && (down != nil) && (left != nil) && (right != nil))
    }
    
    func test_directionFor() {
        let moviment = entity?.component(ofType: MovementComponent.self)
        moviment?.velocity = CGPoint(x: 0, y: 0)
        XCTAssertTrue(moviment != nil)
    }

}
