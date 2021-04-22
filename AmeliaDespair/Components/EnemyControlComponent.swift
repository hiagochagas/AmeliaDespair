//
//  EnemyControlComponent.swift
//  AmeliaDespair
//
//  Created by Hiago Chagas on 20/04/21.
//

import GameplayKit

class EnemyControlComponent: GKComponent {
    var stateMachine: GKStateMachine

    init(states: [GKState]) {
        self.stateMachine = GKStateMachine(states: states)
        // The initial state
        self.stateMachine.enter(IdleState.self)
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        self.stateMachine.currentState?.update(deltaTime: seconds)
    }
    
}