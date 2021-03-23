//
//  MainMenuView.swift
//  AmeliaDespair
//
//  Created by Rodrigo Matos Aguiar on 16/03/21.
//

import UIKit

class MainMenuView: UIView {

    var gameTitle: UILabel = {
        let label = UILabel()
        label.text = "AMELIA'S DESPAIR"
        label.textColor = .labelLightGray
        label.font = UIFont(name: "Gruppo", size: 60)
        return label
    }()

    var playButton: UIButton = {
        let button = UIButton()
        button.setTitle("JOGAR", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat", size: 40)
        button.setTitleColor(.labelLightGray, for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        setupGameTitle()
        setupPlayButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupGameTitle() {
        addSubview(gameTitle)
        gameTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gameTitle.topAnchor.constraint(equalTo: topAnchor, constant: 68),
            gameTitle.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    func setupPlayButton() {
        addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -140),
            playButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
