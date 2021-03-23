//
//  GKStateMachineExtension.swift
//  AmeliaDespair
//
//  Created by Rodrigo Matos Aguiar on 23/03/21.
//

import GameplayKit

extension GKStateMachine {
    func enterIfNeeded(_ state: GKState.Type) {
        guard let currentState = currentState else { return }
        if state != type(of: currentState) {
            self.enter(state)
        }
    }
}
