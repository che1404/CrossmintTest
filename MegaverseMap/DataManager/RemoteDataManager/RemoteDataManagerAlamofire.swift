//
//  RemoteDataManagerAlamofire.swift
//  MegaverseMap
//
//  Created by Roberto Garrido on 16/11/24.
//

import Foundation
import Alamofire

class RemoteDataManagerAlamofire: RemoteDataManager {
    func getMap(_ completion: @escaping (Result<Map, any Error>) -> Void) {
        AF.request(MegaverseAPI.getMap(Constants.candidateID))
            .responseDecodable(of: GetMapResponse.self) { dataResponse in
                switch dataResponse.result {
                case let .success(getMapResponse):
                    completion(.success(getMapResponse.map))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }
    
    func createPolyanet(at row: Int, column: Int, _ completion: @escaping (Result<Void, any Error>) -> Void) {
        let postPolyanetRequest: PostPolyanetRequest
        postPolyanetRequest = .init(candidateId: Constants.candidateID, row: row, column: column)
        AF.request(MegaverseAPI.postPolyanet(postPolyanetRequest))
            .response { dataResponse in
                switch dataResponse.result {
                case .success:
                    completion(.success(()))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }
    
    func create(soloon: Soloon, at row: Int, column: Int, _ completion: @escaping (Result<Void, any Error>) -> Void) {
        let postSoloonRequest: PostSoloonRequest
        postSoloonRequest = .init(candidateId: Constants.candidateID, row: row, column: column, color: soloon.color.rawValue)
        AF.request(MegaverseAPI.postSoloon(postSoloonRequest))
            .response { dataResponse in
                switch dataResponse.result {
                case .success:
                    completion(.success(()))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }
    
    func create(cometh: Cometh, at row: Int, column: Int, _ completion: @escaping (Result<Void, any Error>) -> Void) {
        let postComethRequest: PostComethRequest
        postComethRequest = .init(candidateId: Constants.candidateID, row: row, column: column, direction: cometh.direction.rawValue)
        AF.request(MegaverseAPI.postCometh(postComethRequest))
            .response { dataResponse in
                switch dataResponse.result {
                case .success:
                    completion(.success(()))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }
    
    func delete(megaverseObject: any MegaverseObject, at row: Int, column: Int, _ completion: @escaping (Result<Void, any Error>) -> Void) {
        var requestConvertible: URLRequestConvertible?
        switch megaverseObject.type {
        case .polyanet:
            let deletePolyanetRequest: DeletePolyanetRequest
            deletePolyanetRequest = .init(candidateId: Constants.candidateID, row: row, column: column)
            requestConvertible = MegaverseAPI.deletePolyanet(deletePolyanetRequest)
        case .soloon:
            let deleteSoloonRequest: DeleteSoloonRequest
            deleteSoloonRequest = .init(candidateId: Constants.candidateID, row: row, column: column)
            requestConvertible = MegaverseAPI.deleteSoloon(deleteSoloonRequest)
        case .cometh:
            let deleteComethRequest: DeleteComethRequest
            deleteComethRequest = .init(candidateId: Constants.candidateID, row: row, column: column)
            requestConvertible = MegaverseAPI.deleteCometh(deleteComethRequest)
        }
        guard let requestConvertible else {
            let error: NSError = .init(domain: "delete", code: 0)
            completion(.failure(error))
            return
        }
        
        AF.request(requestConvertible)
            .response { dataResponse in
                switch dataResponse.result {
                case .success:
                    completion(.success(()))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }
    
    func getGoalMap(_ completion: @escaping (Result<[[Goal]], Error>) -> Void) {
        AF.request(MegaverseAPI.getGoalMap(Constants.candidateID))
            .responseDecodable(of: GetGoalMapResponse.self) { dataResponse in
                switch dataResponse.result {
                case let .success(getMapResponse):
                    completion(.success(getMapResponse.goal))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }
}
