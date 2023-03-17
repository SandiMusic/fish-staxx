//
//  TileType.swift
//  fish-staxx
//
//  Created by Sandi Music on 12/03/2023.
//

import UIKit

enum TileType: Int, CustomStringConvertible, CaseIterable {
    
    case bottom = 0, blue, red, magenta, green, black, top, plate
    
    var name: String {
        switch self {
        case .bottom:
            return "bottom"
        case .blue:
            return "blue"
        case .red:
            return "red"
        case .magenta:
            return "magenta"
        case .green:
            return "green"
        case .black:
            return "black"
        case .top:
            return "top"
        case .plate:
            return "plate"
        }
    }
    
    var colour: UIColor {
        switch self {
        case .bottom:
            return .purple
        case .blue:
            return .blue
        case .red:
            return .red
        case .magenta:
            return .magenta
        case .green:
            return .green
        case .black:
            return .black
        case .top:
            return .cyan
        case .plate:
            return .brown
        }
    }
    
    var description: String {
        return self.name
    }
    
    static func generate() -> TileType {
        let uBound: Int = TileType.top.rawValue
        return TileType(rawValue: Int.random(in: 0...uBound))!
    }
    
}
