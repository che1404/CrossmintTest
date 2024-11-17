//
//  MapViewController.swift
//  MegaverseMap
//
//  Created by Roberto Garrido on 16/11/24.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import DifferenceKit

class MapViewController: UIViewController {
    private lazy var compositeDisposable: CompositeDisposable =  .init()
    
    private lazy var createCrossMapButton: UIButton = {
        let createCrossMapButton: UIButton = .init(type: .system)
        createCrossMapButton.setTitle("🚀 Create Cross Megaverse Map", for: .normal)
        
        createCrossMapButton.setTitleColor(.white, for: .normal)
        createCrossMapButton.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        createCrossMapButton.layer.cornerRadius = 10
        createCrossMapButton.layer.shadowColor = UIColor.blue.cgColor
        createCrossMapButton.layer.shadowOpacity = 0.8
        createCrossMapButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        createCrossMapButton.layer.shadowRadius = 4
        createCrossMapButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

        return createCrossMapButton
    }()
    
    private lazy var createPhase2MapButton: UIButton = {
        let createPhase2MapButton: UIButton = .init(type: .system)
        createPhase2MapButton.setTitle("🚀 Create Full Megaverse Map", for: .normal)
        
        createPhase2MapButton.setTitleColor(.white, for: .normal)
        createPhase2MapButton.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        createPhase2MapButton.layer.cornerRadius = 10
        createPhase2MapButton.layer.shadowColor = UIColor.blue.cgColor
        createPhase2MapButton.layer.shadowOpacity = 0.8
        createPhase2MapButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        createPhase2MapButton.layer.shadowRadius = 4
        createPhase2MapButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

        return createPhase2MapButton
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout: UICollectionViewFlowLayout = .init()
        let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(MapCell.self, forCellWithReuseIdentifier: "MapCell")
        
        return collectionView
    }()
    
    let viewModel: MapViewModel
    
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        viewModel.viewDelegate = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        view = .init()
        view.backgroundColor = .white
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        createCrossMapButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(createCrossMapButton)
        NSLayoutConstraint.activate([
            createCrossMapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createCrossMapButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
        
        createPhase2MapButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(createPhase2MapButton)
        NSLayoutConstraint.activate([
            createPhase2MapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createPhase2MapButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
        setupBindings()
        setupCollectionViewLayout()
    }
    
    private func setupBindings() {
        compositeDisposable += viewModel.changeset.producer.startWithValues({ [weak self] (changeset) in
            guard let self = self, let changeset = changeset else { return }
            
            self.collectionView.reload(using: changeset) { [weak self] data in
                self?.viewModel.setData(data)
            }
        })
        
        compositeDisposable += createCrossMapButton.reactive.isHidden <~ viewModel.showPhase1Button.negate()
        
        compositeDisposable += createCrossMapButton.reactive.controlEvents(.touchUpInside).observeValues({ [weak self] _ in
            self?.viewModel.createCrossMapButtonTapped()
        })
        
        compositeDisposable += createPhase2MapButton.reactive.isHidden <~ viewModel.showPhase2Button.negate()
        
        compositeDisposable += createPhase2MapButton.reactive.controlEvents(.touchUpInside).observeValues({ [weak self] _ in
            self?.viewModel.createPhase2MapButtonTapped()
        })
    }
    
    private func setupCollectionViewLayout() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController: UIAlertController = .init(title: title, message: message, preferredStyle: .alert)
        let alertAction: UIAlertAction = .init(title: "OK", style: .default)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
}
