//
//  WalkState.swift
//  AmeliaDespair
//
//  Created by Rodrigo Matos Aguiar on 22/03/21.
//

import GameplayKit

class WalkState: GKState {
    var entity: GKEntity
    var direction = Direction.right {
        didSet {
            if direction != oldValue {
                setAnimation(forDirection: direction)
            }
        }
    }

    var animatedSpriteComponent: AnimatedSpriteComponent? {
        self.entity.component(ofType: AnimatedSpriteComponent.self)
    }

    var movementComponent: MovementComponent? {
        self.entity.component(ofType: MovementComponent.self)
    }

    init(_ entity: GKEntity) {
        self.entity = entity
        super.init()
    }

    override func didEnter(from previousState: GKState?) {
        setAnimation(forDirection: direction)
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        guard let movementComponent = movementComponent else { return }
        direction = directionFor(velocity: movementComponent.velocity)
        movementComponent.move()
        animatedSpriteComponent?.spriteNode.speed = CGFloat.clamp(sin(movementComponent.velocity.length * 0.05), 0.2, 1)
    }

    func setAnimation(forDirection direction: Direction) {
        switch direction {
        case .up:
            animatedSpriteComponent?.setAnimation(atlasName: PlayerAtlasName.walkUp.rawValue)
        case .down:
            animatedSpriteComponent?.setAnimation(atlasName: PlayerAtlasName.walkDown.rawValue)
        case .left:
            animatedSpriteComponent?.setAnimation(atlasName: PlayerAtlasName.walkLeft.rawValue)
        case .right:
            animatedSpriteComponent?.setAnimation(atlasName: PlayerAtlasName.walkRight.rawValue)
        // Temp default (for testing)
//        default:
//            animatedSpriteComponent?.setAnimation(atlasName: PlayerAtlasName.walkDown.rawValue)
        }
    }

    func directionFor(velocity: CGPoint) -> Direction {
        if velocity.x > 0 && velocity.y > 0 {
            if velocity.x > velocity.y {
                return .right
            } else {
                return .up
            }
        } else if velocity.x > 0 && velocity.y < 0 {
            if velocity.x > abs(velocity.y) {
                return .right
            } else {
                return .down
            }
        } else if velocity.x < 0 && velocity.y > 0 {
            if abs(velocity.x) > velocity.y {
                return .left
            } else {
                return .up
            }
        } else if velocity.x < 5 && velocity.y < 5 {
            if abs(velocity.x) > abs(velocity.y) {
                return .left
            } else {
                return .down
            }
        } else {
            return .down
        }
    }
}
