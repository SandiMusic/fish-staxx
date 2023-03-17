//
//  Location.swift
//  three-kings
//
//  Created by Sandi Music on 01/03/2023.
//

class Location: CustomStringConvertible {
    
    var row: Int
    var column: Int
    var offset: Int = 0
    
    init(_ row: Int, _ column: Int) {
        self.row = row
        self.column = column
    }
    
    func drop() {
        if self.offset == 0 {
            self.offset = 1
        } else {
            self.offset = 0
            self.row += 1
        }
    }
    
    var description: String {
        return "Board Location: (\(row),\(column))"
    }
    
}
