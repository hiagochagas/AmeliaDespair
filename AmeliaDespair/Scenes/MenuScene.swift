//
//  MenuScene.swift
//  AmeliaDespair
//
//  Created by Rodrigo Matos Aguiar on 27/03/21.
//

import SpriteKit

class MenuScene: SKScene {

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
        setupGameTitleLabel()
        setupPlayButton()
    }

    func setupGameTitleLabel() {
        gameTitleLabel.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.maxY - 100)
        addChild(gameTitleLabel)
    }

    func setupPlayButton() {
        playButton.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.minY + 140)
        addChild(playButton)
        playButton.tapClosure = {
            let gameScene = GameScene(size: self.size)
            let transition = SKTransition.fade(withDuration: 0.5)
            self.view?.presentScene(gameScene, transition: transition)
        }
    }

}
