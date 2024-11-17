//
//  MapViewModel.swift
//  MegaverseMap
//
//  Created by Roberto Garrido on 16/11/24.
//

import Foundation
import DifferenceKit
import ReactiveSwift

protocol MapViewModelViewDelegate: AnyObject {
    func mapViewModel(showError message: String, viewModel: MapViewModel)
}

final class MapViewModel {
    private let datamanager: DataManager
    private var megaverseMap: MegaverseMap?
    
    weak var viewDelegate: MapViewModelViewDelegate?
    let changeset: MutableProperty<StagedChangeset<[MapSection]>?> = .init(nil)
    let sections: MutableProperty<[MapSection]> = .init([])
    let showPhase1Button: MutableProperty<Bool> = .init(false)
    let showPhase2Button: MutableProperty<Bool> = .init(false)
    
    init(datamanager: DataManager) {
        self.datamanager = datamanager
    }
    
    private func getMapAndHandleResponse() {
        // MARK: Code to fetch the map in the first phase
//        showPhase1Button.value = true
//        datamanager.getMap { [weak self] result in
//            DispatchQueue.main.async { [weak self] in
//                self?.handleGetMapResponse(result)
//            }
//        }
        
        // MARK: Code to fetch the map in the second phase
        showPhase2Button.value = true
        datamanager.getGoalMap { [weak self] result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                self?.handleGetMapResponse(result)
            }
        }
    }
    
    private func handleGetMapResponse(_ response: Result<MegaverseMap, Error>) {
        switch response {
        case let .success(megaverseMap):
            self.megaverseMap = megaverseMap
            createViewModels(megaverseMap)
        case let .failure(error):
            viewDelegate?.mapViewModel(showError: error.localizedDescription, viewModel: self)
            break
        }
    }
    
    private func createViewModels(_ megaverseMap: MegaverseMap) {
        var sections: [MapSection] = []
        for i in 0 ..< megaverseMap.grid.count {
            let mapSectionViewModel: MapSectionViewModel = .init()
            
            var cellViewModels: [MapCellViewModel] = []
            for j in 0 ..< megaverseMap.grid[i].count {
                let cellViewModel = MapCellViewModel(megaverseObject: megaverseMap.grid[i][j])
                cellViewModels.append(cellViewModel)
            }
            let mapSection = MapSection(model: mapSectionViewModel, elements: cellViewModels)
            sections.append(mapSection)
        }
        
        updateChangeset(sections)
    }
    
    
    private func updateChangeset(_ sections: [MapSection]) {
        changeset.value = StagedChangeset<[MapSection]>(source: self.sections.value, target: sections)
    }
    
    func load() {
        getMapAndHandleResponse()
    }
    
    func createCrossMapButtonTapped() {
        MegaverseMapFactory.createCrossMap(dataManager: datamanager) { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
                self?.updateChangeset([])
                self?.getMapAndHandleResponse()
            })
        }
    }
    
    func createPhase2MapButtonTapped() {
        guard let megaverseMap else { return }
        
        MegaverseMapFactory.createFullMegaverseMap(megaverseMap: megaverseMap, dataManager: datamanager) { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
                self?.updateChangeset([])
                self?.getMapAndHandleResponse()
            })
        }
    }
    
    func numberOfItems(in section: Int) -> Int {
        return sections.value[section].elements.count
    }
    
    func numberOfSections() -> Int {
        return sections.value.count
    }
    
    func viewModel(at indexPath: IndexPath) -> (any Differentiable)? {
        return sections.value[indexPath.section].elements[indexPath.row]
    }
    
    func setData(_ data: [MapSection]) {
        sections.value = data
    }
}
