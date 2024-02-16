//
//  ListOfRocketLaunchesViewController.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 25.01.2024.
//

import ViperMcFlurry
import SnapKit

// MARK: - ListOfRocketsLaunchesViewController

final class ListOfRocketsLaunchesViewController: UIViewController {
  
  // MARK: - Collections
  
  var output: ListOfRocketsLaunchesViewOutputProtocol?
  
  // MARK: - UI Properties
  
  private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  
  // MARK: - Properties
  
  private var rocketLaunchCellViewModelElements: [RocketLaunchCell.ViewModel] = []
  
  // MARK: - ViewDidLoad()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    embedViews()
    setupLayout()
    setupAppearance()
    setupBehavior()
    
    output?.viewDidLoad()
  }
}

// MARK: - Setup collection view

private extension ListOfRocketsLaunchesViewController {
  
  func embedViews() {
    view.addSubview(collectionView)
  }
  
  func setupLayout() {
    collectionView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.left.right.equalToSuperview()
    }
  }
  
  func setupAppearance() {
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.backgroundColor = .darkGray
    collectionView.collectionViewLayout = createCompositionalLayout()
    (collectionView.collectionViewLayout as? UICollectionViewFlowLayout).flatMap {
      $0.scrollDirection = .vertical
    }
    
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
  }
  
  func setupBehavior() {
    collectionView.register(RocketLaunchCell.self, forCellWithReuseIdentifier: RocketLaunchCell.reuseID)
    
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
}

// MARK: - Create compositional layout

private extension ListOfRocketsLaunchesViewController {
  func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
      return self.createRocketLaunches()
    }
    return layout
  }
  
  // MARK: - Create Rocket launch section
  
  func createRocketLaunches() -> NSCollectionLayoutSection {
    let itemSize            = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
    let item                = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets      = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
    
    let horizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
    let horizontalGroup     = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize, subitems: [item, item])
    
    let verticalGroupSize   = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0/3.0))
    let verticalGroup       = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitems: [horizontalGroup, horizontalGroup])
    
    let section             = NSCollectionLayoutSection(group: verticalGroup)
    return section
  }
}

// MARK: - UICollectionViewDataSource

extension ListOfRocketsLaunchesViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return rocketLaunchCellViewModelElements.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: RocketLaunchCell.reuseID,
      for: indexPath
    ) as! RocketLaunchCell
    cell.apply(viewModel: rocketLaunchCellViewModelElements[indexPath.row])
    return cell
  }
}

// MARK: - UICollectionViewDelegate

extension ListOfRocketsLaunchesViewController: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    rocketLaunchCellViewModelElements[indexPath.item].onTap()
  }
}

// MARK: - ListOfRocketsLaunchesViewController

extension ListOfRocketsLaunchesViewController: ListOfRocketLaunchesViewProtocol {
  
  func reloadCollectionView(rocketLaunchCellModels: [RocketLaunchCell.ViewModel]) {
    self.rocketLaunchCellViewModelElements = rocketLaunchCellModels
    collectionView.reloadData()
  }
  
}
