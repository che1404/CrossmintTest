//
//  MapCellViewModel.swift
//  MegaverseMap
//
//  Created by Roberto Garrido on 16/11/24.
//

import Foundation
import DifferenceKit
import ReactiveSwift

class MapCellViewModel: Differentiable {
    typealias DifferenceIdentifier = String
    
    var differenceIdentifier: String {
        return UUID().uuidString
    }
    
    let megaverseObjectType: MutableProperty<MegaverseObjectType?> = .init(nil)
    
    init(megaverseObject: MegaverseObject?) {
        megaverseObjectType.value = megaverseObject?.type
    }
    
    func isContentEqual(to source: MapCellViewModel) -> Bool {
        return false
    }
}
