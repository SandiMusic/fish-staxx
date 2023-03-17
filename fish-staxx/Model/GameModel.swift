//
//  Board.swift
//  fish-staxx
//
//  Created by Sandi Music on 12/03/2023.
//

import Foundation
import UIKit

class GameModel {
    
    static let rows: Int = 10
    static let playableRows: Int = 9
    static let lastRow: Int = 8
    static let columns: Int = 4
    static let bottom: Int = 9
    static let startRow: Int = 0
    static let firstRow: Int = 1
    static let firstColumn: Int = 0
    static let lastColumn: Int = 3
    
    var level: Int = 1

    var gameBoard: [[Tile?]] = Array(repeating: Array(repeating: nil, count: columns), count: playableRows)
    
    var plates: [Tile] = [Tile(Location(bottom, 0), tile: .plate),
                          Tile(Location(bottom, 1), tile: .plate),
                          Tile(Location(bottom, 2), tile: .plate),
                          Tile(Location(bottom, 3), tile: .plate)]
    
    var upcomingTokens: [Tile]?
        
    var tickingTokens: [Tile]?
    
    var timer: Timer?
    var speed: Double = 0.2
    
    var didTick: (() -> ())?
    var didTriggerPreview: (() -> ())?
    var didEndGame: (() -> ())?
    var didSwapColumns: (([Tile]) -> ())?
    
    init() {
        self.gameBoard.append(self.plates)
        self.upcomingTokens = self.spawnTokens()
    }
    
    func start() {
        self.setTiles()
        self.resume()
    }
    
    func end() {
        self.timer?.invalidate()
    }
    
    func setTiles() {
        self.tickingTokens = self.upcomingTokens
        self.upcomingTokens = self.spawnTokens()
    }
    
    func spawnTokens() -> [Tile] {
        let numberToSpawn: Int = self.getTokenQuantityOptions()
        var spawns: [Tile] = []
        var options: [Int] = Array(0..<GameModel.columns)
        
        options.shuffle()
        
        for _ in 0..<numberToSpawn {
            if let option: Int = options.popLast() {
                let tile: Tile = Tile(Location(GameModel.startRow, option), tile: .generate())
                spawns.append(tile)
            }
        }
        
        return spawns
    }
    
    func getTokenQuantityOptions() -> Int {
        if self.level < 3 {
            return 2
        } else if self.level < 6 {
            return [2, 3].randomElement()!
        } else {
            return [2, 3, 4].randomElement()!
        }
    }
    
    func tick(_ timer: Timer) {
        if let tiles = self.tickingTokens {
            if self.isPreviewDue() {
                self.didTriggerPreview?()
            }
            
            for tile in tiles {
                if !self.isTileDueToSettle(tile) {
                    tile.location.drop()
                    self.didTick?()
                } else {
                    self.settleTile(tile)
                    
                    if !self.isValidSettleLocation(tile) {
                        self.end()
                        self.didEndGame?()
                        break
                    }
                }
            }
        }
    }
    
    func resume() {
        timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: self.speed, repeats: true, block: self.tick)
    }
    
    func isTileDueToSettle(_ tile: Tile) -> Bool {
        return self.gameBoard[tile.row + 1][tile.column] != nil
    }
    
    func settleTile(_ tile: Tile) {
        self.gameBoard[tile.row][tile.column] = tile
        
        guard self.tickingTokens != nil else {
            return
        }
        
        self.tickingTokens!.removeAll(where: { $0 === tile })
            
        if self.tickingTokens!.isEmpty {
            self.setTiles()
        }
    }
    
    func isValidSettleLocation(_ tile: Tile) -> Bool {
        return tile.row != GameModel.startRow
    }
    
    func isPreviewDue() -> Bool {
        if let tiles = self.tickingTokens {
            return tiles.allSatisfy({ $0.row == GameModel.firstRow }) && tiles.allSatisfy({ $0.offset == 0 })
        }
        return false
    }
    
    func swap(_ column: Int, direction: UISwipeGestureRecognizer.Direction) {
        let target: Int = column + direction.offset
        if self.isColumnOnBoard(target) {
            let colOrder: (higher: Int, lower: Int, top: Int) = self.orderColumns(col1: target, col2: column)
            
            var tiles: [Tile] = []
            
            if let tile = tickingTile(colOrder.lower) {
                if isTickingTileRequiredToSwap(tile: tile, top: colOrder.top) {
                    if self.tickingTokens != nil {
                        for tile in self.tickingTokens! {
                            if tile.column == column {
                                tile.column = target
                            } else {
                                tile.column = column
                            }
                        }
                    }
                }
            }
            
            for i in 0..<self.gameBoard.count {
                if var tile = self.gameBoard[i][column] {
                    tile.column = target
                    tiles.append(tile)
                }
                
                if var tile = self.gameBoard[i][target] {
                    tile.column = column
                    tiles.append(tile)
                }
                self.gameBoard[i].swapAt(column, target)
            }
            self.didSwapColumns?(tiles)
        }
    }
    
    func orderColumns(col1: Int, col2: Int) -> (Int, Int, Int) {
        for row in self.gameBoard {
            if let tile = row[col1] {
                return (tile.column, col2, tile.row)
            }
            
            if let tile = row[col2] {
                return (tile.column, col1, tile.row)
            }
        }
        
        return (col1, col2, GameModel.bottom)
    }
    
    func tickingTile(_ column: Int) -> Tile? {
        if let tiles = self.tickingTokens {
            let tile = tiles.filter({$0.column == column})
            
            if tile.isEmpty {
                return nil
            }
            
            return tile[0]
        }
        return nil
    }
    
    func isColumnOnBoard(_ column: Int) -> Bool {
        return (column >= GameModel.firstColumn) && (column <= GameModel.lastColumn)
    }
    
    func isTickingTileRequiredToSwap(tile: Tile, top: Int) -> Bool {
        return (tile.row + tile.offset) >= top
    }
    
}
