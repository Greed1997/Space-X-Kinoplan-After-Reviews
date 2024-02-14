//
//  ListOfFlickerImagesViewController.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 25.01.2024.
//

import ViperMcFlurry

// MARK: - ListOfFlickerImagesViewController

final class ListOfFlickerImagesViewController: UIViewController {
  
  // MARK: - Connections
  
  var output: ListOfFlickerImagesViewOutputProtocol?
  
  // MARK: - UI Properties
  
  private var collectionView: UICollectionView! = nil
  private var scrollView: UIScrollView!
  private var imageView: UIImageView!
  
  // MARK: - Properties
  
  var flickerImagesCellViewModelElements: [FlickerImageCell.ViewModel] = []
  
  // MARK: - View did load
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupCollectionView()
    setupAppearance()
    
    output?.viewDidLoad()
  }
}
// MARK: - Setup collection view

private extension ListOfFlickerImagesViewController {
  
  private func setupCollectionView() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    view.addSubview(collectionView)
    
    collectionView.register(FlickerImageCell.self, forCellWithReuseIdentifier: FlickerImageCell.reuseID)
    
    collectionView.delegate = self
    collectionView.dataSource = self
  }
}

// MARK: - UICollectionViewDelegate

extension ListOfFlickerImagesViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    flickerImagesCellViewModelElements[indexPath.item].onTap()
  }
}

// MARK: - UICollectionViewDataSource

extension ListOfFlickerImagesViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    flickerImagesCellViewModelElements.count
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlickerImageCell.reuseID, for: indexPath) as! FlickerImageCell
    
    let flickerImagesCellViewModelElement = flickerImagesCellViewModelElements[indexPath.row]
    
    cell.apply(viewModel: flickerImagesCellViewModelElement)
    return cell
  }
}


// MARK: - Create compositional layout

private extension ListOfFlickerImagesViewController {
  
  // MARK: - Create flicker images layout
  
  private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
      return self.createFlickerImagesSection()
    }
    let config = UICollectionViewCompositionalLayoutConfiguration()
    config.scrollDirection = .horizontal
    layout.configuration = config
    return layout
  }
  
  // MARK: - Create flicker images section
  
  private func createFlickerImagesSection() -> NSCollectionLayoutSection {
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
// MARK: - ListOfFlickerImagesViewProtocol

extension ListOfFlickerImagesViewController: ListOfFlickerImagesViewProtocol {
  
  // MARK: - VIPER McFlurry needed func
  
  func instantiateModuleTransitionHandler() -> RamblerViperModuleTransitionHandlerProtocol? {
    return self
  }
  
  // MARK: - Reload collectionView with fetch flicker images
  
  func reloadCollectionView(flickerImagesCellModels: [FlickerImageCell.ViewModel]) {
    self.flickerImagesCellViewModelElements = flickerImagesCellModels
    collectionView.reloadData()
  }
  
  // MARK: - Set title for view controller
  
  func setTitleVC(title: String) {
    navigationItem.title = title
  }
}

// MARK: - Setup appearance

private extension ListOfFlickerImagesViewController {
  
  func setupAppearance() {
    
    collectionView.backgroundColor = .darkGray
  }
}
