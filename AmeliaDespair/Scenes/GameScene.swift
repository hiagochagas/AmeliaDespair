//
//  GameScene.swift
//  AmeliaDespair
//
//  Created by Rodrigo Matos Aguiar on 24/03/21.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {

    var gameNode: GameNode!
    var pauseNode: PauseNode!
    var blurNode: SKEffectNode = {
        let effectNode = SKEffectNode()
        let blur = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius": 10.0])
        effectNode.filter = blur
        effectNode.shouldRasterize = true
        effectNode.shouldEnableEffects = true
        return effectNode
    }()

    private var previousUpdateTime: TimeInterval = TimeInterval()

    var sceneCamera: SKCameraNode = {
        let camera = SKCameraNode()
        return camera
    }()

    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        setupCamera()
        setupGameNode()
        setupPauseNode()
        setupBlurNode()
        createAudioNode()
    }

    override func update(_ currentTime: TimeInterval) {
        let timeSincePreviousUpdate = currentTime - previousUpdateTime
        gameNode.update(timeSincePreviousUpdate)
        previousUpdateTime = currentTime
    }

    func setupCamera() {
        self.camera = sceneCamera
        addChild(sceneCamera)
    }

    func setupGameNode() {
        gameNode = GameNode(camera: sceneCamera)
        gameNode.gameScene = self
        addChild(gameNode)
    }

    func setupPauseNode() {
        pauseNode = PauseNode(gameScene: self)
        addChild(pauseNode)
        pauseNode.isHidden = true
        pauseNode.zPosition = DrawingPlane.foreground.rawValue
    }

    func setupBlurNode() {
        addChild(blurNode)
    }
    // we needed to create this audioNode to stop stuttering the game when it boots
    func createAudioNode() {
        let audioNode = SKAudioNode(fileNamed: "")
        audioNode.run(SKAction.changeVolume(to: 0.0, duration: 0))
        addChild(audioNode)
    }

    func addImageToBlurNode() {
        guard let view = view else { return }
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let image = image {
            let node = SKSpriteNode(texture: SKTexture(image: image))
            blurNode.addChild(node)
        }
        blurNode.position = gameNode.sceneCamera.position
    }

    func returnToMainMenu() {
        let menuScene = MenuScene(size: self.size)
        let transition = SKTransition.fade(withDuration: 0.5)
        self.view?.presentScene(menuScene, transition: transition)
    }

    func pauseGame() {
        pauseNode.position = gameNode.sceneCamera.position
        pauseNode.isHidden = false
        gameNode.isPaused = true
        gameNode.joystick.isUserInteractionEnabled = false
        gameNode.pauseButton.isUserInteractionEnabled = false

        blurNode.isHidden = false
        gameNode.isHidden = true
        gameNode.pauseButton.isHidden = true
        gameNode.joystick.isHidden = true
        addImageToBlurNode()
    }

    func unpauseGame() {
        pauseNode.isHidden = true
        gameNode.isPaused = false
        gameNode.joystick.isUserInteractionEnabled = true
        gameNode.pauseButton.isUserInteractionEnabled = true

        blurNode.isHidden = true
        blurNode.removeAllChildren()
        gameNode.isHidden = false
        gameNode.pauseButton.isHidden = false
        gameNode.joystick.isHidden = false
    }

    func didBegin(_ contact: SKPhysicsContact) {
        if let entity = contact.bodyB.node?.entity {
            let soundComponent = entity.component(ofType: SoundComponent.self)
            soundComponent?.playAudioOnce(audioType: .colliding)
        }
    }
}
