//
//  SoundComponentTests.swift
//  AmeliaDespairTests
//
//  Created by Hiago Chagas on 05/04/21.
//

@testable import AmeliaDespair
import GameplayKit
import AVFoundation
import XCTest

class SoundComponentTests: XCTestCase {
    var entity: GKEntity?
    var soundComponent: SoundComponent? {
        return entity?.component(ofType: SoundComponent.self)
    }
    
    override func setUp() {
        entity = GKEntity()
        entity?.addComponent(SoundComponent(audioTypeToStringDictionary: [.attacking: "", .colliding: "", .growling: "", .soundtrack: "", .walking: ""]))
        entity?.addComponent(AnimatedSpriteComponent())
    }
    
    func test_soundComponent_whenAudioNameEqualsEmptyString_audioNodeShouldBeNil() {
        guard let soundComponent = soundComponent else { return XCTFail("soundComponent could not be unwrapped") }
        guard let type = AudioType.allCases.randomElement() else { return XCTFail("AudioType could not be unwrapped") }
        XCTAssertNotNil(soundComponent.audioPlayer[type])
    }
    
    func test_soundComponent_playAudioOnce_shouldPlay() {
        guard let soundComponent = soundComponent else { return XCTFail("soundComponent could not be unwrapped") }
        guard let type = AudioType.allCases.randomElement() else { return XCTFail("AudioType could not be unwrapped") }
        soundComponent.playAudioOnce(audioType: type)
        let action = soundComponent.spriteNode?.action(forKey: type.rawValue)
        XCTAssertNotNil(action)
    }
    
    func test_soundComponent_playAudioRepeatedly_shouldPlay() {
        guard let soundComponent = soundComponent else { return XCTFail("soundComponent could not be unwrapped") }
        guard let type = AudioType.allCases.randomElement() else { return XCTFail("AudioType could not be unwrapped") }
        soundComponent.playAudioRepeatedly(audioType: type)
        let isPlaying = soundComponent.audioIsPlaying[type]
        XCTAssertTrue(isPlaying != nil && isPlaying == true)
    }
    
    func test_soundComponent_stopAudio_shouldNotPlay() {
        guard let soundComponent = soundComponent else { return XCTFail("soundComponent could not be unwrapped") }
        guard let type = AudioType.allCases.randomElement() else { return XCTFail("AudioType could not be unwrapped") }
        soundComponent.stopAudio(audioType: type)
        let isPlaying = soundComponent.audioIsPlaying[type]
        XCTAssertTrue(isPlaying != nil && isPlaying == false)
    }
    
    func test_soundComponent_initCoder_shouldBeNil() {
        let someSoundComponent = SoundComponent(coder: NSCoder())
        XCTAssertNil(someSoundComponent)
        
    }

}
