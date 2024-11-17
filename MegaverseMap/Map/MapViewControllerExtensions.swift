//
//  MapViewControllerExtensions.swift
//  MegaverseMap
//
//  Created by Roberto Garrido on 17/11/24.
//

import UIKit

extension MapViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalRows = viewModel.numberOfSections()
        let spacing: CGFloat = 10
        let totalSpacing = spacing * CGFloat(totalRows - 1)
        let availableHeight = collectionView.bounds.height - totalSpacing
        let itemHeight = floor(availableHeight / CGFloat(totalRows))
        let itemWidth = itemHeight
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension MapViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cellViewModel: MapCellViewModel = viewModel.viewModel(at: indexPath) as? MapCellViewModel,
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapCell", for: indexPath) as? MapCell {
            cell.viewModel = cellViewModel
            return cell
        }
        
        return .init()
    }
}

extension MapViewController: MapViewModelViewDelegate {
    func mapViewModel(showError message: String, viewModel: MapViewModel) {
        showAlert(title: "Error", message: message)
    }
}
