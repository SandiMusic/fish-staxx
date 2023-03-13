//
//  Tile.swift
//  fish-staxx
//
//  Created by Sandi Music on 12/03/2023.
//

import UIKit

class Tile {

    var tileView: TileView
    var tileType: TileType
    
    var location: Location
        
    var row: Int {
        get {
            return self.location.row
        }
        set(newRow) {
            self.location.row = newRow
        }
    }
    
    var column: Int {
        get {
            return self.location.column
        }
        set(newColumn) {
            self.location.column = newColumn
        }
    }
    
    var offset: Int {
        return self.location.offset
    }
    
    init(_ location: Location, tile: TileType) {
        self.location = location
        self.tileType = tile
        self.tileView = TileView(height: 1.0 / CGFloat(Board.rows), aspect: 3 / 4, parentAspect: 4 / 3)
        
        self.tileView.backgroundColor = self.tileType.colour
    }
    
}
