//
//  CGPointExtension.swift
//  AmeliaDespair
//
//  Created by Rodrigo Matos Aguiar on 27/03/21.
//

import CoreGraphics

extension CGPoint {

    var length: CGFloat {
        return sqrt(self.x * self.x + self.y * self.y)
    }

    var squaredLength: CGFloat {
        return self.x * self.x + self.y * self.y
    }

}
