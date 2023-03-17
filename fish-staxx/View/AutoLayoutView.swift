//
//  AutoLayoutView.swift
//  fish-staxx
//
//  Created by Sandi Music on 13/03/2023.
//

import UIKit

class AutoLayoutView: UIView {
    
    var height: CGFloat
    var aspect: CGFloat
    
    init(height: CGFloat, aspect: CGFloat) {
        self.height = height
        self.aspect = aspect
        
        super.init(frame: CGRect())
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func anchorSize(to: UIView) {
        UIKit.NSLayoutConstraint.activate([self.heightAnchor.constraint(equalTo: to.heightAnchor, multiplier: self.height),
                                           self.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1 / self.aspect)])
        
        self.layoutIfNeeded()
    }
    
}

