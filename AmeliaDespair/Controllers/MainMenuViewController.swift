//
//  MainMenuViewController.swift
//  AmeliaDespair
//
//  Created by Rodrigo Matos Aguiar on 23/03/21.
//

import UIKit

class MainMenuViewController: UIViewController {
    var mainMenuView: MainMenuView!

    override func loadView() {
        self.mainMenuView = MainMenuView()
        self.view = mainMenuView
    }

    override func viewDidLoad() {
        setupButton()
    }

    @objc func startGame() {
        present(GameViewController(), animated: false)
    }

    func setupButton() {
        mainMenuView.playButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
    }

}
