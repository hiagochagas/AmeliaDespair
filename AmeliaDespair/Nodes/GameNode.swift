//
//  GameScene.swift
//  AmeliaDespair
//
//  Created by Hiago Chagas on 15/03/21.
//

import SpriteKit
import GameplayKit

class GameNode: SKNode {

    let player = PlayerEntity()
    let background = BackgroundEntity()
    var parentViewController: GameViewController!
    var sceneCamera: SKCameraNode
    var gameScene: GameScene?

    let joystick: TLAnalogJoystick = {
        let diameter: CGFloat = 100
        let joystick = TLAnalogJoystick(withDiameter: diameter)
        joystick.position = CGPoint(x: diameter / 2 + 50, y: diameter / 2 + 20)
        joystick.handleColor = .white
        return joystick
    }()

    let pauseButton: ImageButton = {
        let button = ImageButton(imageNamed: "PauseIcon")
        button.position = CGPoint(x: UIScreen.main.bounds.width - 50, y: UIScreen.main.bounds.height - 50)
        button.isUserInteractionEnabled = true
        button.setScale(0.4)
        return button
    }()

    var playerMoveComponent: MovementComponent? {
        player.component(ofType: MovementComponent.self)
    }

    var playerAnimatedSpriteComponent: AnimatedSpriteComponent? {
        player.component(ofType: AnimatedSpriteComponent.self)
    }

    var playerControlComponent: PlayerControlComponent? {
        player.component(ofType: PlayerControlComponent.self)
    }

    init(camera: SKCameraNode) {
        self.sceneCamera = camera
        super.init()
        setupPlayerSprite()
        setupJoystick()
        setupBackground()
        setupPauseButton()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupPlayerSprite() {
        guard let playerSprite = playerAnimatedSpriteComponent?.spriteNode else {
            return
        }
        player.component(ofType: CollisionComponent.self)?.loadCollision()
        playerSprite.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        playerSprite.setScale(0.13)
        addChild(playerSprite)
        
    }

    func setupJoystick() {
        if let spritePosition = playerAnimatedSpriteComponent?.spriteNode.position {
            sceneCamera.position = spritePosition
        }
        joystick.position = convert(joystick.position, to: sceneCamera)
        sceneCamera.addChild(joystick)
        joystick.on(.move) { (movingJoystick) in
            let velocity = CGPoint(x: movingJoystick.velocity.x / 2, y: movingJoystick.velocity.y / 2)
            self.playerMoveComponent?.velocity = velocity
            if velocity != CGPoint.zero {
                self.playerControlComponent?.stateMachine.enterIfNeeded(WalkState.self)
            }
        }
        joystick.on(.end) { _ in
            self.playerMoveComponent?.velocity = CGPoint.zero
            self.playerControlComponent?.stateMachine.enterIfNeeded(IdleState.self)
        }
    }

//    func setupActionButton() {
//
//    }

    func setupBackground() {
        guard let backgroundSprite = background.component(ofType: AnimatedSpriteComponent.self)?.spriteNode else {
            return
        }
        background.component(ofType: CollisionComponent.self)?.loadCollision(shape: .edgeLoop)
        backgroundSprite.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        backgroundSprite.zPosition = DrawingPlane.background.rawValue
        backgroundSprite.setScale(0.5)
        addChild(backgroundSprite)
    }

    func setupPauseButton() {
        pauseButton.position = convert(pauseButton.position, to: sceneCamera)
        pauseButton.tapClosure = {
            self.gameScene?.pauseGame()
        }
        sceneCamera.addChild(pauseButton)
    }

    func update(_ timeSincePreviousUpdate: TimeInterval) {
        if let spritePosition = playerAnimatedSpriteComponent?.spriteNode.position {
            sceneCamera.position = spritePosition
        }
        playerControlComponent?.update(deltaTime: timeSincePreviousUpdate)
    }

}
