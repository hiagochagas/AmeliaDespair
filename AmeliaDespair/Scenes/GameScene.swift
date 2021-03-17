//
//  GameScene.swift
//  AmeliaDespair
//
//  Created by Hiago Chagas on 15/03/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    // TODO: Adjust joystick for different devices (screen sizes)
    let player = PlayerEntity()

    private var previousUpdateTime: TimeInterval = TimeInterval()

    let joystick: TLAnalogJoystick = {
        let diameter: CGFloat = 100
        let joystick = TLAnalogJoystick(withDiameter: diameter)
        joystick.position = CGPoint(x: diameter / 2 + 50, y: diameter / 2 + 20)
        joystick.handleColor = .white
        return joystick
    }()

    var playerMoveComponent: MoveComponent? {
        player.component(ofType: MoveComponent.self)
    }

    var playerAnimatedSpriteComponent: AnimatedSpriteComponent? {
        player.component(ofType: AnimatedSpriteComponent.self)
    }

    var sceneCamera: SKCameraNode = {
        let camera = SKCameraNode()
        return camera
    }()

    override func didMove(to view: SKView) {
        setupCamera()
        setupPlayerSprite()
        setupJoystick()
    }

    func setupCamera() {
        self.camera = sceneCamera
        addChild(sceneCamera)
    }

    func setupPlayerSprite() {
        guard let playerSprite = playerAnimatedSpriteComponent?.spriteNode else {
            return
        }
        playerSprite.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        addChild(playerSprite)
    }

    func setupJoystick() {
        if let spritePosition = playerAnimatedSpriteComponent?.spriteNode.position {
            sceneCamera.position = spritePosition
        }
        joystick.position = convert(joystick.position, to: sceneCamera)
        sceneCamera.addChild(joystick)
        joystick.on(.move) { (movingJoystick) in
            self.playerMoveComponent?.setVelocity(velocity: movingJoystick.velocity)
        }
        joystick.on(.end) { _ in
            self.playerMoveComponent?.setVelocity(velocity: CGPoint(x: 0, y: 0))
        }
    }

    override func update(_ currentTime: TimeInterval) {
        if let spritePosition = playerAnimatedSpriteComponent?.spriteNode.position {
            sceneCamera.position = spritePosition
        }
        let timeSincePreviousUpdate = currentTime - previousUpdateTime
        playerMoveComponent?.update(deltaTime: timeSincePreviousUpdate)
        previousUpdateTime = currentTime
    }

}
