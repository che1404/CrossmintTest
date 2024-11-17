//
//  MapSectionViewModel.swift
//  MegaverseMap
//
//  Created by Roberto Garrido on 17/11/24.
//

import DifferenceKit
import Foundation

class MapSectionViewModel: Differentiable {
    typealias DifferenceIdentifier = String
    
    var differenceIdentifier: String {
        return UUID().uuidString
    }
    
    func isContentEqual(to source: MapSectionViewModel) -> Bool {
        return false
    }
}
