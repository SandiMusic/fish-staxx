//
//  ExtensionSwipe.swift
//  fish-staxx
//
//  Created by Sandi Music on 14/03/2023.
//

import UIKit

extension UISwipeGestureRecognizer.Direction {
    var offset: Int {
        switch self {
        case .up:
            return -1
        case .down:
            return 1
        case .right:
            return 1
        case .left:
            return -1
        default:
            return 0
        }
    }
}
