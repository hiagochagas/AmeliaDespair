//
//  MenuScene.swift
//  AmeliaDespair
//
//  Created by Rodrigo Matos Aguiar on 27/03/21.
// swiftlint:disable identifier_name

import SpriteKit
import AVFoundation

class MenuScene: SKScene {
    var audioPlayer: AVAudioPlayer?

    var gameTitleLabel: SKLabelNode = {
        let label = SKLabelNode(fontNamed: "Gruppo")
        label.text = "AMELIA'S DESPAIR"
        label.fontColor = .labelLightGray
        label.fontSize = 60
        return label
    }()

    var playButton: LabelButton = {
        let button = LabelButton(fontNamed: "Montserrat")
        button.text = "JOGAR"
        button.fontColor = .labelLightGray
        button.fontSize = 40
        return button
    }()

    override func didMove(to view: SKView) {
        backgroundColor = .black
        playAudio()
        preloadGameScene()
        self.setupGameTitleLabel()
        self.setupPlayButton()
    }

    func playAudio() {
        let path = Bundle.main.path(forResource: "mainMenuSong", ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.volume = 0.2
            audioPlayer?.numberOfLoops = .max
            audioPlayer?.play()
        } catch {
            // couldn't load file :(
        }
    }
    func preloadGameScene() {
        let scene = GameScene(size: self.size)
        scene.setup()
    }

    func setupGameTitleLabel() {
        gameTitleLabel.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.maxY - 100)
        addChild(gameTitleLabel)
    }

    func setupPlayButton() {
        playButton.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.minY + 140)
        addChild(playButton)
        playButton.tapClosure = {
            self.audioPlayer?.stop()
            let gameScene = GameScene(size: self.size)
            gameScene.playAudio()
            let transition = SKTransition.fade(withDuration: 0.5)
            self.view?.presentScene(gameScene, transition: transition)
        }
    }

}
