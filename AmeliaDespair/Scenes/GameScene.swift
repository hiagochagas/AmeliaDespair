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
    let background = BackgroundEntity()

    private var previousUpdateTime: TimeInterval = TimeInterval()

    let joystick: TLAnalogJoystick = {
        let diameter: CGFloat = 100
        let joystick = TLAnalogJoystick(withDiameter: diameter)
        joystick.position = CGPoint(x: diameter / 2 + 50, y: diameter / 2 + 20)
        joystick.handleColor = .white
        return joystick
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

    var sceneCamera: SKCameraNode = {
        let camera = SKCameraNode()
        return camera
    }()

    override func didMove(to view: SKView) {
        setupCamera()
        setupPlayerSprite()
        setupJoystick()
        setupBackground()
//        Wall to test the collision
//        let wall = SKShapeNode(rect: CGRect(x: 400, y: 500, width: 50, height: 100))
//        addChild(wall)
//        wall.physicsBody = SKPhysicsBody(edgeLoopFrom: wall.frame)
//        wall.physicsBody?.affectedByGravity = false
    }

    func setupCamera() {
        self.camera = sceneCamera
        addChild(sceneCamera)
    }

    func setupPlayerSprite() {
        guard let playerSprite = playerAnimatedSpriteComponent?.spriteNode else {
            return
        }
        player.component(ofType: CollisionComponent.self)?.loadCollision()
        playerSprite.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        playerSprite.setScale(0.2)
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

    func setupActionButton() {

    }

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

    override func update(_ currentTime: TimeInterval) {
        if let spritePosition = playerAnimatedSpriteComponent?.spriteNode.position {
            sceneCamera.position = spritePosition
        }
        let timeSincePreviousUpdate = currentTime - previousUpdateTime
        playerControlComponent?.update(deltaTime: timeSincePreviousUpdate)
        previousUpdateTime = currentTime
    }

}
