//
//  CGFloatExtension.swift
//  AmeliaDespair
//
//  Created by Rodrigo Matos Aguiar on 28/03/21.
// swiftlint:disable identifier_name

import CoreGraphics

extension CGFloat {
    static func clamp(_ value: CGFloat, _ min: CGFloat, _ max: CGFloat) -> CGFloat {
        if value < min {
            return min
        } else if value > max {
            return max
        } else {
            return value
        }
    }
}
