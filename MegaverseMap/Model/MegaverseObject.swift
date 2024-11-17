//
//  MegaverseObject.swift
//  MegaverseMap
//
//  Created by Roberto Garrido on 16/11/24.
//

enum MegaverseObjectType: Int {
    case polyanet = 0
    case soloon = 1
    case cometh = 2
}

protocol MegaverseObject: AnyObject {
    var type: MegaverseObjectType { get }
}
