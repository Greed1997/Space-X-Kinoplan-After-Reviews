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
  
  private let collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
  )
  private let imageView = UIImageView()
  
  private let backButton = UIButton(type: .system)
  
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
    collectionView.collectionViewLayout = createFlowLayout()
    (collectionView.collectionViewLayout as? UICollectionViewFlowLayout).flatMap {
      $0.scrollDirection = .horizontal
    }
    
    backButton.setTitle("Back", for: .normal)
    backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
    backButton.titleLabel?.font         = UIFont.systemFont(ofSize: 18)
    backButton.semanticContentAttribute = .forceRightToLeft
    
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
  }
  
  func setupBehavior() {
    collectionView.register(FlickerImageCell.self, forCellWithReuseIdentifier: .cell)
    
    collectionView.delegate = self
    collectionView.dataSource = self
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    
    backButton.addTarget(
      self,
      action: #selector(onBackButtonItemButtonTapped),
      for: .touchUpInside
    )
  }
  
}

// MARK: - Create flow layout

private extension ListOfFlickerImagesViewController {
  
  func createFlowLayout() -> UICollectionViewFlowLayout {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(
      width : self.view.bounds.width / 2.2,
      height: self.view.bounds.height / 3.3
    )
    layout.sectionInset            = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    layout.minimumInteritemSpacing = 10
    layout.minimumLineSpacing      = 10
    return layout
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
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: .cell,
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
    output?.onBackButtonTapped()
  }
}

// MARK: - ListOfFlickerImagesViewProtocol

extension ListOfFlickerImagesViewController: ListOfFlickerImagesViewProtocol {
  
  func setData(viewModel: FlickerImageViewModel) {
    navigationItem.title = viewModel.title
    self.flickerImageViewModel = viewModel.flickerImageViewModel
    collectionView.reloadData()
  }
  
}

private extension String {
  static let cell = "FlickerImageCell"
}
