//
//  DrawingPlane.swift
//  AmeliaDespair
//
//  Created by Rodrigo Matos Aguiar on 19/03/21.
// swiftlint:disable identifier_name

import CoreGraphics

enum DrawingPlane: CGFloat {
    case background = -2
    case beforeground = -1
    case middleground = 1
    case foreground = 2
    case afterground = 3
    case character = 4
    case shadowLayer = 7
    case lighting = 8
    case hud = 9
}
