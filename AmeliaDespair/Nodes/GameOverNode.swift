//
//  GameOverNode.swift
//  AmeliaDespair
//
//  Created by Rodrigo Matos Aguiar on 08/04/21.
// swiftlint:disable line_length

import SpriteKit

class GameOverNode: SKNode {

    var gameScene: GameScene

    var panel: SKShapeNode = {
        let shape = SKShapeNode(rect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.height * 0.55), cornerRadius: 30)
        shape.fillColor = .black
        shape.strokeColor = .clear
        return shape
    }()

    var pauseLabel: SKLabelNode = {
        let label = SKLabelNode(fontNamed: "Montserrat")
        label.text = "FIM DE JOGO"
        label.fontColor = .labelLightGray
        label.fontSize = 32
        return label
    }()

    var restartButton: LabelButton = {
        let button = LabelButton(fontNamed: "Montserrat")
        button.text = "reiniciar"
        button.fontColor = .labelLightGray
        button.fontSize = 32
        return button
    }()

    var quitButton: LabelButton = {
        let button = LabelButton(fontNamed: "Montserrat")
        button.text = "sair"
        button.fontColor = .labelLightGray
        button.fontSize = 32
        return button
    }()

    init(gameScene: GameScene) {
        self.gameScene = gameScene
        super.init()
        setupNodes()
    }

    func setupNodes() {
        addChild(panel)
        addChild(pauseLabel)
        addChild(restartButton)
        addChild(quitButton)

        panel.position = CGPoint(x: panel.frame.midX * -1, y: panel.frame.midY * -1)
        pauseLabel.position = CGPoint(x: 0, y: panel.frame.maxY - pauseLabel.frame.height - 40)
        restartButton.position = CGPoint(x: 0, y: pauseLabel.frame.minY - restartButton.frame.height - 35)
        quitButton.position = CGPoint(x: 0, y: restartButton.frame.minY - quitButton.frame.height - 16)

        restartButton.tapClosure = {
            self.gameScene.restartGame()
        }

        quitButton.tapClosure = {
            self.gameScene.returnToMainMenu()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
