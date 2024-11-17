//
//  MegaverseAPI.swift
//  MegaverseMap
//
//  Created by Roberto Garrido on 16/11/24.
//

import Foundation
import Alamofire

typealias CandidateID = String

enum MegaverseAPI: URLRequestConvertible, Sendable {
    case getMap(CandidateID)
    case postPolyanet(PostPolyanetRequest)
    case postSoloon(PostSoloonRequest)
    case postCometh(PostComethRequest)
    case deletePolyanet(DeletePolyanetRequest)
    case deleteSoloon(DeleteSoloonRequest)
    case deleteCometh(DeleteComethRequest)
    case getGoalMap(CandidateID)
    
    private var method: HTTPMethod {
        switch self {
        case .getMap: return .get
        case .postPolyanet: return .post
        case .postSoloon: return .post
        case .postCometh: return .post
        case .deletePolyanet: return .delete
        case .deleteSoloon: return .delete
        case .deleteCometh: return .delete
        case .getGoalMap: return .get
        }
    }
    
    private var path: String {
        switch self {
        case let .getMap(candidateID): return "/map/\(candidateID)"
        case .postPolyanet: return "/polyanets"
        case .postSoloon: return "/soloons"
        case .postCometh: return "/comeths"
        case .deletePolyanet: return "/polyanets"
        case .deleteSoloon: return "/soloons"
        case .deleteCometh: return "/soloons"
        case let .getGoalMap(candidateID): return "/map/\(candidateID)/goal"
        }
    }
    
    private var parameters: Codable? {
        switch self {
        case .getMap: return nil
        case let .postPolyanet(request): return request
        case let .postSoloon(request): return request
        case let .postCometh(request): return request
        case let .deletePolyanet(request): return request
        case let .deleteSoloon(request): return request
        case let .deleteCometh(request): return request
        case .getGoalMap: return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url: URL = .init(string: "https://challenge.crossmint.io/api") else {
            fatalError()
        }
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.headers.add(.contentType("application/json"))

        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONEncoder().encode(parameters)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
