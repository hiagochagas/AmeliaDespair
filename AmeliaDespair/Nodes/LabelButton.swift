//
//  LabelButton.swift
//  AmeliaDespair
//
//  Created by Rodrigo Matos Aguiar on 26/03/21.
// swiftlint:disable line_length

import SpriteKit

class LabelButton: SKLabelNode {

    // This may look weird, and it is. The fontNamed designated initializer actually calls the default initializer, and if I don't override it, the app crashes. How cool.
    override init() {
        super.init()
    }

    override init(fontNamed fontName: String?) {
        super.init(fontNamed: fontName)
        isUserInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var tapClosure: (() -> Void)?

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let tapClosure = tapClosure {
            tapClosure()
        }
    }

}
