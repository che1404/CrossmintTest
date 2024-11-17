//
//  PostSoloonRequest.swift
//  MegaverseMap
//
//  Created by Roberto Garrido on 17/11/24.
//

final class PostSoloonRequest: Codable, Sendable {
    let candidateId: String
    let row: Int
    let column: Int
    let color: String
    
    init(candidateId: String, row: Int, column: Int, color: String) {
        self.candidateId = candidateId
        self.row = row
        self.column = column
        self.color = color
    }
}
