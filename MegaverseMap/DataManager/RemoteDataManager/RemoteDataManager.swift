//
//  RemoteDataManager.swift
//  MegaverseMap
//
//  Created by Roberto Garrido on 16/11/24.
//

protocol RemoteDataManager: AnyObject {
    func getMap(_ completion: @escaping (Result<Map, Error>) -> Void)
    func getGoalMap(_ completion: @escaping (Result<[[Goal]], Error>) -> Void)
    func createPolyanet(at row: Int, column: Int, _ completion: @escaping (Result<Void, Error>) -> Void)
    func create(soloon: Soloon, at row: Int, column: Int, _ completion: @escaping (Result<Void, Error>) -> Void)
    func create(cometh: Cometh, at row: Int, column: Int, _ completion: @escaping (Result<Void, Error>) -> Void)
    func delete(megaverseObject: MegaverseObject, at row: Int, column: Int, _ completion: @escaping (Result<Void, Error>) -> Void)
}
