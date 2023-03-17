//
//  GameViewController.swift
//  fish-staxx
//
//  Created by Sandi Music on 11/03/2023.
//

import UIKit

class GameViewController: UIViewController {
    
    let model: GameModel = GameModel()
    
    var boardView: BoardView = BoardView(height: 0.5, aspect: 4 / 3)
    
    let tileAspectRatio: CGFloat = 3 / 4
    let tileHeight: CGFloat = 1.0 / CGFloat(GameModel.rows)
    
    var tilePadding: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.displaySetup()
        self.assignCallbacks()
        self.enableTouchRecognition()
        self.model.start()
    }
 
    func displaySetup() {
        self.configureBoard()
        self.addPlates()
        self.onPreview()
    }
    
    func configureBoard() {
        self.view.addSubview(self.boardView)
        self.boardView.backgroundColor = .yellow
        self.boardView.anchorCenter(to: self.view)
        self.boardView.anchorSize(to: self.view)
    }
        
    func addPlates() {
        for tile in self.model.plates {
            self.boardView.addSubview(tile.tileView)
            tile.tileView.anchorSize(to: self.boardView)
            tile.tileView.anchorAtBoardLocation(location: tile.location, on: self.boardView)
        }
    }
    
    func onPreview() {
        if let tiles = self.model.upcomingTokens {
            for tile in tiles {
                self.boardView.addSubview(tile.tileView)
                tile.tileView.anchorSize(to: self.boardView)
                tile.tileView.anchorAtBoardLocation(location: tile.location, on: self.boardView)
            }
        }
    }
    
    func assignCallbacks() {
        self.model.didTick = self.onTick
        self.model.didTriggerPreview = self.onPreview
        self.model.didEndGame = self.endGame
        self.model.didSwapColumns = self.onSwap
    }
    
    func onTick() {
        if let tiles = self.model.tickingTokens {
            for tile in tiles {
                UIView.animate(withDuration: 0.01, delay: 0.0, options: .curveLinear, animations: {
                    tile.tileView.updateLocationConstraints(location: tile.location, parent: self.boardView)
                }, completion: nil)
            }
        }
    }
    
    func onSwap(tiles: [Tile]) {
        for tile in tiles {
            UIView.animate(withDuration: 0.01, delay: 0.0, options: .curveLinear, animations: {
                tile.tileView.updateLocationConstraints(location: tile.location, parent: self.boardView)
            }, completion: nil)
        }
    }
    
    func endGame() {
        print("game ended")
    }
    
    @objc func didSwipe(_ sender: UISwipeGestureRecognizer) {
        let startingPoint = sender.location(in: self.boardView)
        let startingLocation = self.translatePoint(startingPoint)

        self.model.swap(startingLocation.column, direction: sender.direction)
    }
    
    @objc func didSwipeDown(_ sender: UISwipeGestureRecognizer) {

    }
    
    // MARK: - Touch recognition
    
    func enableTouchRecognition() {
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        rightSwipe.direction = .right
        self.boardView.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        leftSwipe.direction = .left
        self.boardView.addGestureRecognizer(leftSwipe)
        
        let downwardSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeDown(_:)))
        downwardSwipe.direction = .down
        self.boardView.addGestureRecognizer(downwardSwipe)
        
    }
    
    /// Returns the board location for a touch point on the game board
    ///
    /// - Parameters point: Starting point of the touch within the boards coordinate system.
    /// - Returns: Location corresponding to the starting touch point.
    func translatePoint(_ point: CGPoint) -> Location {
        let rowColumnWidth: CGFloat = self.boardView.frame.width / CGFloat(GameModel.columns)
        let row: Int = Int(floor(point.y / rowColumnWidth))
        let column: Int = Int(floor(point.x / rowColumnWidth))
        
        return Location(row, column)
    }
    
}
