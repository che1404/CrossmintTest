//
//  MegaverseMapFactory.swift
//  MegaverseMap
//
//  Created by Roberto Garrido on 16/11/24.
//

import Foundation
import ReactiveSwift

struct Postion {
    let x: Int
    let y: Int
}

class MegaverseMapFactory {
    static func createFullMegaverseMap(megaverseMap: MegaverseMap, dataManager: DataManager, _ completion: @escaping () -> Void) {
        var producers: [SignalProducer<Void, Error>] = []
        
        for rowIndex in 0 ..< megaverseMap.grid.count {
            for columnIndex in 0 ..< megaverseMap.grid[rowIndex].count {
                let position = Postion(x: rowIndex, y: columnIndex)
                
                if megaverseMap.grid[rowIndex][columnIndex] is Polyanet {
                    producers.append(MegaverseMapFactory.createPolyanetProducer(dataManager: dataManager, position: position).delay(1.0, on: QueueScheduler.main))
                } else if let soloon = megaverseMap.grid[rowIndex][columnIndex] as? Soloon {
                    producers.append(MegaverseMapFactory.createSoloonProducer(soloon: soloon, dataManager: dataManager, position: position).delay(1.0, on: QueueScheduler.main))
                } else if let cometh = megaverseMap.grid[rowIndex][columnIndex] as? Cometh {
                    producers.append(MegaverseMapFactory.createComethProducer(cometh: cometh, dataManager: dataManager, position: position).delay(1.0, on: QueueScheduler.main))
                }
            }
        }
        
        SignalProducer(producers)
            .flatten(.concat)
            .startWithCompleted {
                print("Full map completed")
                completion()
            }
    }
    
    static func createCrossMap(dataManager: DataManager, _ completion: @escaping () -> Void) {
        var producers: [SignalProducer<Void, Error>] = []
        let size = 11
        for i in 0..<size {
            guard i > 1 && i < 9 else { continue }
            // 2, 2
            // 2, 8
            let diagonal1 = Postion(x: i, y: i)
            let diagonal2 = Postion(x: i, y: size - i - 1)
            
            producers.append(MegaverseMapFactory.createPolyanetProducer(dataManager: dataManager, position: diagonal1).delay(1.0, on: QueueScheduler.main))
            producers.append(MegaverseMapFactory.createPolyanetProducer(dataManager: dataManager, position: diagonal2).delay(1.0, on: QueueScheduler.main))
        }
        
        SignalProducer(producers)
            .flatten(.concat)
            .startWithCompleted {
                print("Cross map completed")
                completion()
            }
    }
    
    static func createPolyanetProducer(dataManager: DataManager, position: Postion) -> SignalProducer<Void, Error> {
        return .init { observer, _ in
            dataManager.createPolyanet(at: position.x, column: position.y) { result in
                switch result {
                case .success:
                    print("Polyanet created at \(position)")
                    observer.send(value: ())
                    observer.sendCompleted()
                case .failure(let error):
                    print("Error creating Polyanet: \(error)")
                    observer.send(error: error)
                }
            }
        }
    }
    
    static func createSoloonProducer(soloon: Soloon, dataManager: DataManager, position: Postion) -> SignalProducer<Void, Error> {
        return .init { observer, _ in
            dataManager.createSoloon(soloon, row: position.x, column: position.y) { result in
                switch result {
                case .success:
                    print("Soloon created at \(position)")
                    observer.send(value: ())
                    observer.sendCompleted()
                case .failure(let error):
                    print("Error creating Soloon: \(error)")
                    observer.send(error: error)
                }
                
            }
        }
    }
    
    static func createComethProducer(cometh: Cometh, dataManager: DataManager, position: Postion) -> SignalProducer<Void, Error> {
        return .init { observer, _ in
            dataManager.createCometh(cometh, row: position.x, column: position.y) { result in
                switch result {
                case .success:
                    print("Cometh created at \(position)")
                    observer.send(value: ())
                    observer.sendCompleted()
                case .failure(let error):
                    print("Error creating Cometh: \(error)")
                    observer.send(error: error)
                }
                
            }
        }
    }
}
