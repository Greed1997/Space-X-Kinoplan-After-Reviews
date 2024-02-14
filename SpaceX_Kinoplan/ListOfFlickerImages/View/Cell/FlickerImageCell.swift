//
//  FlickerImageCell.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 27.01.2024.
//

import Kingfisher
import SnapKit

// MARK: - FlickerImageCell

final class FlickerImageCell: UICollectionViewCell {
  
  // MARK: - reuse ID
  
  static var reuseID: String {
    "FlickerImageCell"
  }
  
  // MARK: - UI Properties
  
  private let flickerImageView = UIImageView()
  
  // MARK: - Layout Subviews
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = 10
    layer.masksToBounds = true
  }
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .gray
    
    embedSubviews(subviews: flickerImageView)
    setupLayout()
    setupAppearance()
    }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
// MARK: - Apply UI elements content

extension FlickerImageCell {
  
  func apply(viewModel: FlickerImageCell.ViewModel) {
    
    flickerImageView.kf.setImage(
      with: viewModel.flickerImageURL,
      placeholder: UIImage(named: "Cosmos"),
      options: [
      .scaleFactor(contentScaleFactor),
      .transition(.fade(1)),
      .cacheOriginalImage
    ])
  }
}

// MARK: - Setup cell content

private extension FlickerImageCell {
  
  // MARK: - Embed subviews for stackView
  // maybe need to be public to all UICollectionViewCell
  func embedSubviews(subviews: UIView...) {
    subviews.forEach { subview in
      subview.translatesAutoresizingMaskIntoConstraints = false
      addSubview(subview)
    }
  }
  
  // MARK: - Setup layout
  
  func setupLayout() {
    flickerImageView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
      make.bottom.equalToSuperview()
    }
  }
  
  // MARK: - Setup appearance
  
  func setupAppearance() {
    flickerImageView.layer.cornerRadius = 10
    flickerImageView.layer.masksToBounds = true
  }
  
}
// MARK: - FlickerImageCell view model

extension FlickerImageCell {
  
  struct ViewModel {
    
    let flickerImageURL: URL?
    
    let onTap: () -> Void
  }
}
