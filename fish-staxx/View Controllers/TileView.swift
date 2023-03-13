//
//  AutoLayoutView.swift
//  fish-staxx
//
//  Created by Sandi Music on 11/03/2023.
//

import UIKit
import Foundation

class TileView: BoardView {
    
    var boardLocationTopConstraint: NSLayoutConstraint?
    var boardLocationLeftConstraint: NSLayoutConstraint?
    
    var padding: CGFloat
    var width: CGFloat
    
    init(height: CGFloat, aspect: CGFloat, parentAspect: CGFloat) {
        self.width = height * parentAspect * (1.0 / aspect)
        self.padding = (1.0 - self.width * CGFloat(Board.columns)) / CGFloat(Board.columns + 1)
        
        super.init(height: height, aspect: aspect)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func anchorAtBoardLocation(location: Location, on: UIView) {
        let verticalOffset: CGFloat = self.getVerticalOffset(parent: on, location: location)
        let horizontalOffset: CGFloat = self.getHorizontalOffset(parent: on, location: location)
        
        self.boardLocationTopConstraint = self.topAnchor.constraint(equalTo: on.topAnchor, constant: verticalOffset)
        self.boardLocationLeftConstraint = self.leftAnchor.constraint(equalTo: on.leftAnchor, constant: horizontalOffset)
        
        UIKit.NSLayoutConstraint.activate([self.boardLocationTopConstraint!,
                                           self.boardLocationLeftConstraint!])
        
        self.layoutIfNeeded()
        
    }
    
    func updateLocationConstraints(location: Location, parent: UIView) {
        self.boardLocationTopConstraint?.constant = self.getVerticalOffset(parent: parent, location: location)
        self.boardLocationLeftConstraint?.constant = self.getHorizontalOffset(parent: parent, location: location)
    }
    
    func getHorizontalOffset(parent: UIView, location: Location) -> CGFloat {
        let horizontalPadding: CGFloat = (parent.frame.width * self.padding) * (CGFloat(location.column) + CGFloat(1.0))
        let horizontalTokenOffset: CGFloat = self.frame.width * CGFloat(location.column)
        
        return horizontalPadding + horizontalTokenOffset
    }
    
    func getVerticalOffset(parent: UIView, location: Location) -> CGFloat {
        let verticalTokenOffset: CGFloat = self.frame.height * CGFloat(location.row)
        
        return verticalTokenOffset
    }
    
}
