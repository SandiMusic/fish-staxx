//
//  AutoLayoutView.swift
//  fish-staxx
//
//  Created by Sandi Music on 11/03/2023.
//

import UIKit

class BoardView: AutoLayoutView {
    
    func anchorCenter(to: UIView) {
        UIKit.NSLayoutConstraint.activate([self.centerXAnchor.constraint(equalTo: to.centerXAnchor),
                                           self.centerYAnchor.constraint(equalTo: to.centerYAnchor)])
        
        self.layoutIfNeeded()
    }
    
}
