//
//  GetMapResponse.swift
//  MegaverseMap
//
//  Created by Roberto Garrido on 16/11/24.
//

import Foundation

// MARK: - GetMapResponse
struct GetMapResponse: Codable {
    let map: Map
}

// MARK: - Map
struct Map: Codable {
    let id: String
    let content: [[Content?]]
    let candidateID: String
    let phase, v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case content
        case candidateID = "candidateId"
        case phase
        case v = "__v"
    }
}

// MARK: - Content
struct Content: Codable {
    let type: Int
    let color, direction: String?
}
