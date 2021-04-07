//
//  SoundComponent.swift
//  AmeliaDespair
//
//  Created by Hiago Chagas on 05/04/21.
//

import GameplayKit
import SpriteKit
import AVFoundation

enum AudioType: String, CaseIterable {
    case walking
    case growling
    case attacking
    case colliding
    case soundtrack
}

class SoundComponent: GKComponent {
    var audioStrings: [AudioType : String] = [:]
    var audioPlayer: [AudioType : SKAudioNode] = [:]
    // gambiarra to make the tests work
    var audioIsPlaying: [AudioType: Bool] = [:]
    var spriteNode: SKSpriteNode? {
        self.entity?.component(ofType: AnimatedSpriteComponent.self)?.spriteNode
    }

    func playAudioRepeatedly(audioType: AudioType) {
        if let audioPlayer = audioPlayer[audioType] {
            spriteNode?.addChild(audioPlayer)
            self.audioIsPlaying[audioType] = true
        }
    }

    func playAudioOnce(audioType: AudioType) {
        self.audioIsPlaying[audioType] = true
        if let audioValue = audioStrings[audioType] {
            let actions = SKAction.sequence([
                SKAction.playSoundFileNamed(audioValue, waitForCompletion: true),
                SKAction.run {
                    self.audioIsPlaying[audioType] = false
                }
            ])
            spriteNode?.run(actions, withKey: audioType.rawValue)
        }
    }

    func stopAudio(audioType: AudioType) {
        if let audioNode = audioPlayer[audioType] {
            audioNode.removeFromParent()
            self.audioIsPlaying[audioType] = false
        }
    }

    init(audioTypeToStringDictionary: [AudioType: String]) {
        super.init()
        self.audioStrings = audioTypeToStringDictionary
        for audioType in self.audioStrings.keys {
            if let value = audioTypeToStringDictionary[audioType] {
                let audioNode = SKAudioNode(fileNamed: value)
                audioNode.autoplayLooped = true
                self.audioPlayer[audioType] = audioNode
                self.audioIsPlaying[audioType] = false
            }
        }
    }

    required init?(coder: NSCoder) {
        return nil
    }

}
