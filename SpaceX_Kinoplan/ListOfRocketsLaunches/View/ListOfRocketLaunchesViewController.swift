//
//  ListOfRocketLaunchesViewController.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 25.01.2024.
//

import ViperMcFlurry

// MARK: - ListOfRocketsLaunchesViewController

final class ListOfRocketsLaunchesViewController: UIViewController {
  
  // MARK: - Collections
  
  var output: ListOfRocketsLaunchesViewOutputProtocol?
  
  // MARK: - UI Properties
  
  private var collectionView: UICollectionView! = nil
  
  // MARK: - Properties
  
  private var rocketLaunchCellViewModelElements: [RocketLaunchCell.ViewModel] = []
  
  // MARK: - ViewDidLoad()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupCollectionView()
    setupAppearance()
    
    output?.viewDidLoad()
  }
}

// MARK: - Setup collection view

private extension ListOfRocketsLaunchesViewController {
  private func setupCollectionView() {
    
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    view.addSubview(collectionView)
    
    collectionView.register(RocketLaunchCell.self, forCellWithReuseIdentifier: RocketLaunchCell.reuseID)
    
    collectionView.delegate = self
    collectionView.dataSource = self
  
  }
}

// MARK: - Create compositional layout

private extension ListOfRocketsLaunchesViewController {
  private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
        return self.createRocketLaunches()
    }
    let config = UICollectionViewCompositionalLayoutConfiguration()
    config.scrollDirection = .horizontal
    layout.configuration = config
    return layout
  }
  
  // MARK: - Create Rocket launch section
  
  private func createRocketLaunches() -> NSCollectionLayoutSection {
    let width = UIScreen.main.bounds.width
    let inset = (width - (2 * (width * 0.4))) / 3
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
    group.interItemSpacing = .fixed(inset)
    let section = NSCollectionLayoutSection(group: group)
    
    section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: inset, bottom: 0, trailing: inset)
    section.interGroupSpacing = inset
    section.orthogonalScrollingBehavior = .continuous
    
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
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketLaunchCell.reuseID, for: indexPath) as! RocketLaunchCell
    let rocketLaunchCellViewModelElement = rocketLaunchCellViewModelElements[indexPath.row]
    cell.apply(viewModel: rocketLaunchCellViewModelElement)
    return cell
  }
}

// MARK: - UICollectionViewDelegate

extension ListOfRocketsLaunchesViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    rocketLaunchCellViewModelElements[indexPath.item].onTap()
  }
}
// MARK: - ListOfRocketsLaunchesViewController

extension ListOfRocketsLaunchesViewController: ListOfRocketLaunchesViewProtocol {
  
  func instantiateModuleTransitionHandler() -> RamblerViperModuleTransitionHandlerProtocol? {
    return self
  }
  
  func reloadCollectionView(rocketLaunchCellModels: [RocketLaunchCell.ViewModel]) {
    self.rocketLaunchCellViewModelElements = rocketLaunchCellModels
    collectionView.reloadData()
  }
  
}
// MARK: - Setup appearance

private extension ListOfRocketsLaunchesViewController {
  func setupAppearance() {
    collectionView.backgroundColor = .darkGray
  }
}
