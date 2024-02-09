//
//  ListOfRocketLaunchesViewController.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 25.01.2024.
//

import ViperMcFlurry

// MARK: - ListOfRocketsLaunchesViewController
final class ListOfRocketsLaunchesViewController: UIViewController {
  
  // MARK: - SectionKind
  enum Section: Int, CaseIterable {
    case rocketLaunchesInfo
  }
  // MARK: - Collections
  var output: ListOfRocketsLaunchesViewOutputProtocol?
  
  // MARK: - Properties
  private var collectionView: UICollectionView! = nil
  private var dataSource: UICollectionViewDiffableDataSource<Section, RocketLaunchCellModel>?
  
  // MARK: - ViewDidLoad()
  override func viewDidLoad() {
    super.viewDidLoad()
    output?.viewDidLoad()
    setupCollectionView()
    setupAppearance()
    createDataSource()
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
    
  }
}
// MARK: - Create compositional layout
private extension ListOfRocketsLaunchesViewController {
  private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
      guard let section = Section(rawValue: sectionIndex) else {
        fatalError("Unknown section kind")
      }
      switch section {
      case .rocketLaunchesInfo:
        return self.createRocketLaunches()
      }
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
// MARK: - Create data source
private extension ListOfRocketsLaunchesViewController {
  private func createDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, RocketLaunchCellModel>(collectionView: collectionView, cellProvider: { collectionView, indexPath, rocketLaunch in
      guard let section = Section(rawValue: indexPath.section) else {
        fatalError("Unknow section kind")
      }
      switch section {
      case .rocketLaunchesInfo:
        return self.configure(collectionView: collectionView, cellType: RocketLaunchCell.self, with: rocketLaunch, for: indexPath)
      }
    })
  }
}

// MARK: - UICollectionViewDelegate
extension ListOfRocketsLaunchesViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    output?.getSelectedRocketLaunch(index: indexPath.item)
  }
}
// MARK: - ListOfRocketsLaunchesViewController
extension ListOfRocketsLaunchesViewController: ListOfRocketLaunchesViewProtocol {
  func instantiateModuleTransitionHandler() -> RamblerViperModuleTransitionHandlerProtocol? {
    return self
  }
  
  func reloadCollectionView(rocketLaunchCellModels: [RocketLaunchCellModel]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, RocketLaunchCellModel>()
    snapshot.appendSections([.rocketLaunchesInfo])
    snapshot.appendItems(rocketLaunchCellModels, toSection: .rocketLaunchesInfo)
    dataSource?.apply(snapshot, animatingDifferences: false)
  }
  
}
// MARK: - Setup appearance
private extension ListOfRocketsLaunchesViewController {
  func setupAppearance() {
    collectionView.backgroundColor = .darkGray
  }
}
