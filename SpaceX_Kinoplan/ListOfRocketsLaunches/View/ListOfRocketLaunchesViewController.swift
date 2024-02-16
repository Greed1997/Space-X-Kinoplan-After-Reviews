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
  
  private let collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
  )
  
  // MARK: - Properties
  
  private var arrayOfRocketLaunchCellViewModels: [RocketLaunchCell.ViewModel] = []
  
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
    collectionView.collectionViewLayout = createFlowLayout()
    (collectionView.collectionViewLayout as? UICollectionViewFlowLayout).flatMap {
      $0.scrollDirection = .vertical
    }
    
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
  }
  
  func setupBehavior() {
    collectionView.register(RocketLaunchCell.self, forCellWithReuseIdentifier: .cell)
    
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
}

// MARK: - Create flow layout

private extension ListOfRocketsLaunchesViewController {
  
  func createFlowLayout() -> UICollectionViewFlowLayout {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(
      width: self.view.bounds.width / 2.2,
      height: self.view.bounds.height / 3.3
    )
    layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    layout.minimumInteritemSpacing = 10
    layout.minimumLineSpacing = 10
    return layout
  }
  
}

// MARK: - UICollectionViewDataSource

extension ListOfRocketsLaunchesViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    1
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return arrayOfRocketLaunchCellViewModels.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: .cell,
      for: indexPath
    ) as! RocketLaunchCell
    
    cell.apply(viewModel: arrayOfRocketLaunchCellViewModels[indexPath.row])
    
    return cell
  }
}

// MARK: - UICollectionViewDelegate

extension ListOfRocketsLaunchesViewController: UICollectionViewDelegate {
  
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    arrayOfRocketLaunchCellViewModels[indexPath.item].onTap()
  }
  
}

// MARK: - ListOfRocketsLaunchesViewController

extension ListOfRocketsLaunchesViewController: ListOfRocketLaunchesViewProtocol {
  
  func set(viewModel: [RocketLaunchCell.ViewModel]) {
    self.arrayOfRocketLaunchCellViewModels = viewModel
    collectionView.reloadData()
  }
  
}

// MARK: - String extension

private extension String {
  static let cell = "RocketLaunchCell"
}
