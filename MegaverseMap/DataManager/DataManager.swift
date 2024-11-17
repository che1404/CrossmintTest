//
//  DataManager.swift
//  MegaverseMap
//
//  Created by Roberto Garrido on 16/11/24.
//

/// This class coordinates remote API calls with local the cache, and delivers plain "database-tech agnostic" objects to the caller
class DataManager {
    let remoteDataManager: RemoteDataManager
    
    init(remoteDataManager: RemoteDataManager) {
        self.remoteDataManager = remoteDataManager
    }
    
    func createPolyanet(at row: Int, column: Int, _ completion: @escaping (Result<Void, Error>) -> Void) {
        remoteDataManager.createPolyanet(at: row, column: column, completion)
    }
    
    func createSoloon(_ soloon: Soloon, row: Int, column: Int, _ completion: @escaping (Result<Void, Error>) -> Void) {
        remoteDataManager.create(soloon: soloon, at: row, column: column, completion)
    }
    
    func createCometh(_ cometh: Cometh, row: Int, column: Int, _ completion: @escaping (Result<Void, Error>) -> Void) {
        remoteDataManager.create(cometh: cometh, at: row, column: column, completion)
    }
    
    func getMap(_ completion: @escaping (Result<MegaverseMap, Error>) -> Void) {
        remoteDataManager.getMap { result in
            switch result {
            case let .success(map):
                let megaverseMap: MegaverseMap = .createCrossMegaverseMapFrom(map: map)
                completion(.success(megaverseMap))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func getGoalMap(_ completion: @escaping (Result<MegaverseMap, Error>) -> Void) {
        remoteDataManager.getGoalMap { result in
            switch result {
            case let .success(goal):
                let megaverseMap: MegaverseMap = .createMegaverseMapFrom(goal: goal)
                completion(.success(megaverseMap))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

extension MegaverseMap {
    static func createMegaverseMapFrom(goal: [[Goal]]) -> MegaverseMap {
        let megaverseMap: MegaverseMap
        megaverseMap = .init(phase: 2, grid: Array(repeating: Array(repeating: nil, count: goal.count), count: goal.count))
        
        for rowIndex in 0 ..< goal.count {
            for columIndex in 0 ..< goal.count {
                if let goal: Goal = goal[safe: rowIndex]?[safe: columIndex] {
                    let megaverseObject: MegaverseObject? = goal.toMegaverseObject()
                    megaverseMap.grid[rowIndex][columIndex] = megaverseObject
                } else {
                    megaverseMap.grid[rowIndex][columIndex] = nil
                }
            }
        }
        return megaverseMap
    }
    
    static func createCrossMegaverseMapFrom(map: Map) -> MegaverseMap {
        let megaverseMap: MegaverseMap
        megaverseMap = .init(phase: 1, grid: Array(repeating: Array(repeating: nil, count: map.content.count), count: map.content.count))
        
        for rowIndex in 0 ..< map.content.count {
            for columIndex in 0 ..< map.content.count {
                if let content: Content = map.content[rowIndex][columIndex], let megaverseObjectType = MegaverseObjectType(rawValue: content.type) {
                    switch megaverseObjectType {
                    case .polyanet:
                        megaverseMap.grid[rowIndex][columIndex] = Polyanet()
                    case .soloon:
                        guard let color = content.color,
                              let soloonColor = MegaverseColor(rawValue: color) else { break }
                        
                        megaverseMap.grid[rowIndex][columIndex] = Soloon(color: soloonColor)
                    case .cometh:
                        guard let direction = content.direction,
                              let comethDirection = MegaverseDirection(rawValue: direction) else { break }
                        
                        megaverseMap.grid[rowIndex][columIndex] = Cometh(direction: comethDirection)
                    }
                } else {
                    megaverseMap.grid[rowIndex][columIndex] = nil
                }
            }
        }
        
        return megaverseMap
    }
}

extension Goal {
    func toMegaverseObject() -> MegaverseObject? {
        switch self {
        case .blueSoloon:
            return Soloon(color: .blue)
        case .downCometh:
            return Cometh(direction: .down)
        case .leftCometh:
            return Cometh(direction: .left)
        case .polyanet:
            return Polyanet()
        case .purpleSoloon:
            return Soloon(color: .purple)
        case .redSoloon:
            return Soloon(color: .red)
        case .rightCometh:
            return Cometh(direction: .right)
        case .space:
            return nil
        case .upCometh:
            return Cometh(direction: .up)
        case .whiteSoloon:
            return Soloon(color: .white)
        }
    }
}
