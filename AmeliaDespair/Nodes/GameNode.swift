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
    let background = SceneryEntity(imageName: "GameBackground")
    let enemy = EnemyEntity()
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

    var enemyMoveComponent: MovementComponent? {
        enemy.component(ofType: MovementComponent.self)
    }

    var enemyAnimatedSpriteComponent: AnimatedSpriteComponent? {
        enemy.component(ofType: AnimatedSpriteComponent.self)
    }

    var enemyControlComponent: EnemyControlComponent? {
        enemy.component(ofType: EnemyControlComponent.self)
    }

    init(camera: SKCameraNode) {
//        camera.setScale(3.0)
        self.sceneCamera = camera
        super.init()
        setupPlayerSprite()
        setupEnemySprite()
        setupJoystick()
        setupBackground()
        setupRooms()
        setupPauseButton()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupPlayerSprite() {
        guard let playerSprite = playerAnimatedSpriteComponent?.spriteNode else {
            return
        }
        if let collisionComponent = player.component(ofType: CollisionComponent.self) {
            let physicsBody = SKPhysicsBody(circleOfRadius: 100, center: CGPoint(x: 0, y: -400))
            collisionComponent.loadCollision(physicsBody: physicsBody)
        }
        playerSprite.zPosition = DrawingPlane.amelia.rawValue
        playerSprite.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        playerSprite.setScale(0.15)
        addChild(playerSprite)
    }

    func setupEnemySprite() {
        guard let enemySprite = enemy.component(ofType: AnimatedSpriteComponent.self)?.spriteNode else { return }
        if let collisionComponent = enemy.component(ofType: CollisionComponent.self) {
            let physicsBody = SKPhysicsBody(circleOfRadius: 150, center: CGPoint(x: 0, y: -400))
            collisionComponent.loadCollision(physicsBody: physicsBody)
        }
        enemySprite.position = CGPoint(x: 150, y: 150)
        enemySprite.setScale(0.15)
        addChild(enemySprite)
    }

    func setupJoystick() {
        if let spritePosition = playerAnimatedSpriteComponent?.spriteNode.position {
            sceneCamera.position = spritePosition
        }
        joystick.zPosition = DrawingPlane.hud.rawValue
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

    func setupBackground() {
        guard let backgroundSprite = background.component(ofType: AnimatedSpriteComponent.self)?.spriteNode else {
            return
        }
        background.component(ofType: CollisionComponent.self)?.loadCollision(shape: .edgeLoop)
        backgroundSprite.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        backgroundSprite.zPosition = DrawingPlane.background.rawValue
        addChild(backgroundSprite)
    }

    func setupRooms() {
        let officeNode = OfficeNode()
        let hallwayNode = HallwayNode()
        let livingRoomNode = LivingRoomNode()
        let kitchenNode = KitchenNode()
        officeNode.position = CGPoint(x: UIScreen.main.bounds.midX + 700, y: UIScreen.main.bounds.midY - 790)
        addChild(officeNode)
        hallwayNode.position = CGPoint(x: UIScreen.main.bounds.midX + 490, y: UIScreen.main.bounds.minY + 250)
        addChild(hallwayNode)
        guard let backgroundSprite = background.component(ofType: AnimatedSpriteComponent.self)?.spriteNode else {
            return
        }
        backgroundSprite.addChild(livingRoomNode)
        kitchenNode.position = CGPoint(x: UIScreen.main.bounds.midX - 750, y: UIScreen.main.bounds.minY + 250)
        addChild(kitchenNode)
    }

//    func setupBackgroundWalls() {
//        guard let backgroundSprite = background.component(ofType: AnimatedSpriteComponent.self)?.spriteNode else {
//            return
//        }
//        let backgroundWalls = BackgroundWallsNode()
//        backgroundSprite.addChild(backgroundWalls)
//    }

    func setupPauseButton() {
        pauseButton.position = convert(pauseButton.position, to: sceneCamera)
        pauseButton.tapClosure = {
            self.gameScene?.pauseGame()
        }
        sceneCamera.addChild(pauseButton)
    }

    func update(_ timeSincePreviousUpdate: TimeInterval) {
        guard let playerPosition = playerAnimatedSpriteComponent?.spriteNode.position else { return }
        guard let enemyPosition = enemyAnimatedSpriteComponent?.spriteNode.position else { return }
        if(self.isPaused != true) {
            self.moveEnemy(playerPosition: playerPosition, enemyPosition: enemyPosition)
            playerControlComponent?.update(deltaTime: timeSincePreviousUpdate)
            enemyControlComponent?.update(deltaTime: timeSincePreviousUpdate)
        }
        if let spritePosition = playerAnimatedSpriteComponent?.spriteNode.position {
            sceneCamera.position = spritePosition
        }
    }

    func moveEnemy(playerPosition: CGPoint, enemyPosition: CGPoint) {
        let xDistance = pow(enemyPosition.x - playerPosition.x, 2.0)
        let yDistance = pow(enemyPosition.y - playerPosition.y, 2.0)
        let distance = (xDistance + yDistance).squareRoot()
        if(distance <= 500.0) {
            let velocity = determineVelocity(playerPosition: playerPosition, enemyPosition: enemyPosition)
            self.enemyMoveComponent?.velocity = velocity
            enemyControlComponent?.stateMachine.enterIfNeeded(EnemyWalkState.self)
        } else {
            enemyControlComponent?.stateMachine.enterIfNeeded(IdleState.self)
        }
    }

    func determineVelocity(playerPosition: CGPoint, enemyPosition: CGPoint) -> CGPoint {
        var velocityX: CGFloat = 7.0
        var velocityY: CGFloat = 7.0
        if abs(playerPosition.x - enemyPosition.x) <= 10 {
            velocityX = 0
        } else if (playerPosition.x < enemyPosition.x) {
            velocityX *= -1
        }
        if abs(playerPosition.y - enemyPosition.y) <= 10 {
            velocityY = 0
        } else if (playerPosition.y < enemyPosition.y) {
            velocityY *= -1
        }
        return CGPoint(x: velocityX, y: velocityY)
    }
}
