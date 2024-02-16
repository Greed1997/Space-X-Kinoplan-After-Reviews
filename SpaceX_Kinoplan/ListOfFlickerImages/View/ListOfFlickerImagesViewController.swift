//
//  ListOfFlickerImagesViewController.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 25.01.2024.
//

import ViperMcFlurry
import SnapKit

// MARK: - ListOfFlickerImagesViewController

final class ListOfFlickerImagesViewController: UIViewController {
  
  // MARK: - Connections
  
  var output: ListOfFlickerImagesViewOutputProtocol?
  
  // MARK: - UI Properties
  
  private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  private let imageView = UIImageView()
  
  private let backButton = UIButton(type: .system)
  
  private lazy var newBackLeftBarButtonItem = UIBarButtonItem(customView: backButton)
  
  // MARK: - Properties
  
  private var flickerImageViewModel: [FlickerImageCell.FlickerImageViewModel] = []
  
  // MARK: - View did load
  
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

private extension ListOfFlickerImagesViewController {
  
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
      $0.scrollDirection = .horizontal
    }
    
    backButton.setTitle("Back", for: .normal)
    backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
    backButton.titleLabel?.font         = UIFont.systemFont(ofSize: 18)
    backButton.semanticContentAttribute = .forceRightToLeft
    
    navigationItem.leftBarButtonItem = newBackLeftBarButtonItem
    
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
  }
  
  func setupBehavior() {
    collectionView.register(FlickerImageCell.self, forCellWithReuseIdentifier: FlickerImageCell.reuseID)
    
    collectionView.delegate = self
    collectionView.dataSource = self
    
    backButton.addTarget(
      self,
      action: #selector(onBackButtonItemButtonTapped),
      for: .touchUpInside
    )
  }
  
}

// MARK: - Create compositional layout

private extension ListOfFlickerImagesViewController {
  
  // MARK: - Create flicker images layout
  
  func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
      return self.createFlickerImagesSection()
    }
    return layout
  }
  
  // MARK: - Create flicker images section
  
  func createFlickerImagesSection() -> NSCollectionLayoutSection {
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

extension ListOfFlickerImagesViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    flickerImageViewModel.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: FlickerImageCell.reuseID,
      for: indexPath
    ) as! FlickerImageCell
    
    cell.apply(viewModel: flickerImageViewModel[indexPath.row])
    
    return cell
  }
  
}

// MARK: - UICollectionViewDelegate

extension ListOfFlickerImagesViewController: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    flickerImageViewModel[indexPath.item].onTap()
  }
  
}

// MARK: - Objc methods

private extension ListOfFlickerImagesViewController {
  @objc func onBackButtonItemButtonTapped() {
    output?.dismiss()
  }
}

// MARK: - ListOfFlickerImagesViewProtocol

extension ListOfFlickerImagesViewController: ListOfFlickerImagesViewProtocol {
  
  func setData(viewModel: ViewModel) {
    navigationItem.title = viewModel.title
    self.flickerImageViewModel = viewModel.flickerImageViewModel
    collectionView.reloadData()
  }
  
}
