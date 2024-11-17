//
//  Cometh.swift
//  MegaverseMap
//
//  Created by Roberto Garrido on 16/11/24.
//

class Cometh: MegaverseObject {
    var type: MegaverseObjectType = .cometh
    let direction: MegaverseDirection
    
    init(direction: MegaverseDirection) {
        self.direction = direction
    }
}
