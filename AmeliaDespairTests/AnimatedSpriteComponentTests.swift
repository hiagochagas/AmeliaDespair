//
//  AnimatedSpriteComponentTests.swift
//  AmeliaDespairTests
//
//  Created by Hiago Chagas on 07/04/21.
//

import XCTest
import GameplayKit
@testable import AmeliaDespair

class AnimatedSpriteComponentTests: XCTestCase {
    
    var entity: GKEntity?
    var spriteComponent: AnimatedSpriteComponent? {
        return entity?.component(ofType: AnimatedSpriteComponent.self)
    }
        
    override func setUp() {
        entity = GKEntity()
        entity?.addComponent(AnimatedSpriteComponent())
        spriteComponent?.animationAtlas = SKTextureAtlas(dictionary: ["something" : UIImage(systemName: "square")!])
    }
    
    func test_animatedSpriteComponent_setAnimation_isValid(){
        let atlasName = "testAtlas"
        spriteComponent?.setAnimation(atlasName: atlasName, textures: spriteComponent?.animationAtlas)
        let action = spriteComponent?.spriteNode.action(forKey: atlasName)
        XCTAssertNotNil(action)
    }
    
    func test_animatedSpriteComponent_initImageNamed_textureNotNil() {
        let animatedSpriteComponent = AnimatedSpriteComponent(imageName: "square")
        XCTAssertNotNil(animatedSpriteComponent.spriteNode.texture)
    }
    
    func test_animatedSpriteComponent_initCoder_shouldBeNil() {
        let someComponent = AnimatedSpriteComponent(coder: NSCoder())
        XCTAssertNil(someComponent)
        
    }
    
}
