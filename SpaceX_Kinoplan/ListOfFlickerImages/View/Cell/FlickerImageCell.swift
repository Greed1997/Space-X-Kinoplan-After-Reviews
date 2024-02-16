//
//  FlickerImageCell.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 27.01.2024.
//

import Kingfisher
import SnapKit

extension FlickerImageCell {
  
  struct FlickerImageViewModel {
    let imageURL: URL?
    let onTap: () -> Void
  }
  
}

final class FlickerImageCell: UICollectionViewCell {
  
  // MARK: - UI Properties
  
  private let flickerImageView = UIImageView()
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    embedSubviews()
    setupLayout()
    setupAppearance()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

// MARK: - Setup cell content

private extension FlickerImageCell {
  
  // MARK: - Embed subviews for stackView
  
  func embedSubviews() {
    addSubview(flickerImageView)
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
    backgroundColor = .gray
    layer.cornerRadius = 10
    layer.masksToBounds = true
    flickerImageView.layer.cornerRadius = 10
    flickerImageView.layer.masksToBounds = true
  }
  
}

// MARK: - Public methods

extension FlickerImageCell {
  
  func apply(viewModel: FlickerImageCell.FlickerImageViewModel) {
    flickerImageView.kf.setImage(
      with: viewModel.imageURL,
      placeholder: UIImage.placeholder,
      options: [
        .scaleFactor(contentScaleFactor),
        .transition(.fade(1)),
        .cacheOriginalImage
      ])
  }
  
}
