//
//  IdleStateTest.swift
//  AmeliaDespairTests
//
//  Created by Vitor Bryan on 21/04/21.
//

import XCTest
import GameplayKit
@testable import AmeliaDespair

class IdleStateTest: XCTestCase {

    var entity: GKEntity?
    var idleState: IdleState? {
        return IdleState(entity!)
    }
    
    func test_didEnter() {
        let sound = entity?.component(ofType: SoundComponent.self)
        sound?.stopAudio(audioType: .walking)
        let playing = sound?.audioIsPlaying
        XCTAssertTrue(playing != nil)
        
    }

}
