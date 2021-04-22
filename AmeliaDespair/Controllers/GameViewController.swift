//
//  GameViewController.swift
//  AmeliaDespair
//
//  Created by Hiago Chagas on 15/03/21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    var gameSceneView = SKView()

//    override func loadView() {
//        super.loadView()
//        gameSceneView = SKView()
//        self.view = gameSceneView
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameScene()
    }

    func setupGameScene() {
        view.addSubview(gameSceneView)
        gameSceneView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gameSceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameSceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gameSceneView.topAnchor.constraint(equalTo: view.topAnchor),
            gameSceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        let scene = MenuScene(size: view.bounds.size)
        scene.scaleMode = .aspectFit
        scene.anchorPoint = CGPoint(x: 0, y: 0)
        gameSceneView.presentScene(scene)
        gameSceneView.ignoresSiblingOrder = true
        // Debugging booleans
//        gameSceneView.showsFPS = true
//        gameSceneView.showsNodeCount = true
        gameSceneView.showsPhysics = true
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
