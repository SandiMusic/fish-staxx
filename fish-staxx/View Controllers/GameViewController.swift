//
//  GameViewController.swift
//  fish-staxx
//
//  Created by Sandi Music on 11/03/2023.
//

import UIKit

class GameViewController: UIViewController {
    
    let board: Board = Board()
    
    var boardView: BoardView = BoardView(height: 0.5, aspect: 4 / 3)
    
    let tileAspectRatio: CGFloat = 3 / 4
    let tileHeight: CGFloat = 1.0 / CGFloat(Board.rows)
    
    var tilePadding: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.displaySetup()
    }
 
    func displaySetup() {
        configureBoard()
        addPlates()
    }
    
    func configureBoard() {
        self.view.addSubview(self.boardView)
        self.boardView.backgroundColor = .yellow
        self.boardView.anchorCenter(to: self.view)
        self.boardView.anchorSize(to: self.view)
    }
        
    func addPlates() {
        for tile in self.board.plates {
            self.boardView.addSubview(tile.tileView)
            tile.tileView.anchorSize(to: self.boardView)
            tile.tileView.anchorAtBoardLocation(location: tile.location, on: self.boardView)
        }
    }
    
}
