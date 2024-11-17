//
//  GetGoalMapResponse.swift
//  MegaverseMap
//
//  Created by Roberto Garrido on 16/11/24.
//

import Foundation

// MARK: - GetGoalMapResponse
struct GetGoalMapResponse: Codable {
    let goal: [[Goal]]
}

enum Goal: String, Codable {
    case blueSoloon = "BLUE_SOLOON"
    case downCometh = "DOWN_COMETH"
    case leftCometh = "LEFT_COMETH"
    case polyanet = "POLYANET"
    case purpleSoloon = "PURPLE_SOLOON"
    case redSoloon = "RED_SOLOON"
    case rightCometh = "RIGHT_COMETH"
    case space = "SPACE"
    case upCometh = "UP_COMETH"
    case whiteSoloon = "WHITE_SOLOON"
}
