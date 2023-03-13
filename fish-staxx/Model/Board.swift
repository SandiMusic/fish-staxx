//
//  Board.swift
//  fish-staxx
//
//  Created by Sandi Music on 12/03/2023.
//

import Foundation

class Board {
    
    static let rows: Int = 10
    static let playableRows: Int = 9
    static let columns: Int = 4
    static let bottom: Int = 9
    
    var level: Int = 1

    var gameBoard: [[Tile?]] = Array(repeating: Array(repeating: nil, count: columns), count: rows)
    
    let plates: [Tile] = [Tile(Location(bottom, 0), tile: .plate),
                          Tile(Location(bottom, 1), tile: .plate),
                          Tile(Location(bottom, 2), tile: .plate),
                          Tile(Location(bottom, 3), tile: .plate)]
    
    var upcomingTokens: [Tile]? = nil
        
    var tickingTokens: [Tile]? = nil
    
    func setUpcomingTokens() {
        self.upcomingTokens = self.spawnTokens()
    }
    
}
