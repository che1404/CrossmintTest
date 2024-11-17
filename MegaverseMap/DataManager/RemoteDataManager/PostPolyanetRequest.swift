//
//  PostPolyanetRequest.swift
//  MegaverseMap
//
//  Created by Roberto Garrido on 16/11/24.
//


final class PostPolyanetRequest: Codable, Sendable {
    let candidateId: String
    let row: Int
    let column: Int
    
    init(candidateId: String, row: Int, column: Int) {
        self.candidateId = candidateId
        self.row = row
        self.column = column
    }
}
