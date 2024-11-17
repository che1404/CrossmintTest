//
//  MapCell.swift
//  MegaverseMap
//
//  Created by Roberto Garrido on 16/11/24.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class MapCell: UICollectionViewCell {
    private lazy var serialDisposable: SerialDisposable = .init()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    var viewModel: MapCellViewModel? {
        didSet {
            guard let viewModel else { return }
            setup(with: viewModel)
        }
    }
    
    private func setup(with viewModel: MapCellViewModel) {
        let compositeDisposable: CompositeDisposable
        compositeDisposable = .init()
        serialDisposable.inner = compositeDisposable
        
        compositeDisposable += imageView.reactive.image <~ viewModel.megaverseObjectType.producer.map({ megaverseObjectType in
            return megaverseObjectType?.cellImage ?? UIImage(named: "space")
        })
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        serialDisposable.dispose()
        serialDisposable = .init()
    }
}

extension MegaverseObjectType {
    var cellImage: UIImage? {
        switch self {
        case .polyanet: return UIImage(named: "polyanet")
        case .soloon: return UIImage(named: "soloon")
        case .cometh: return UIImage(named: "cometh")
        }
    }
}
