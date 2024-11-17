//
//  PostComethRequest.swift
//  MegaverseMap
//
//  Created by Roberto Garrido on 17/11/24.
//

final class PostComethRequest: Codable, Sendable {
    let candidateId: String
    let row: Int
    let column: Int
    let direction: String
    
    init(candidateId: String, row: Int, column: Int, direction: String) {
        self.candidateId = candidateId
        self.row = row
        self.column = column
        self.direction = direction
    }
}
