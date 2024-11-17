//
//  MegaverseMap.swift
//  MegaverseMap
//
//  Created by Roberto Garrido on 16/11/24.
//


class MegaverseMap {
    var phase: Int
    var grid: [[MegaverseObject?]]
    
    init(phase: Int, grid: [[MegaverseObject?]]) {
        self.phase = phase
        self.grid = grid
    }
}
