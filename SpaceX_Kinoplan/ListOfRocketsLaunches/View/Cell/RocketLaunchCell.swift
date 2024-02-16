//
//  RocketLaunchCell.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 25.01.2024.
//

import Kingfisher
import SnapKit

extension RocketLaunchCell {
  
  struct ViewModel {
    
    let missionName: String?
    let missionPatchImageViewURL: URL?
    let missionDate: String?
    let onTap: () -> Void
    
  }
}

final class RocketLaunchCell: UICollectionViewCell {
  
  // MARK: - Reuse ID
  
  static var reuseID: String = .cell
  
  // MARK: - UI Properties
  
  private let missionNameLabel = UILabel()
  
  private let missionPatchImageView = UIImageView()
  
  private let dateLabel = UILabel()
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    embedViews()
    setupLayout()
    setupAppearance()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Setup cell content

private extension RocketLaunchCell {
  
  // MARK: - Embed subviews for stackView
  
  func embedViews() {
    let subviews = [
      missionNameLabel,
      missionPatchImageView,
      dateLabel
    ]
    subviews.forEach { subview in
      addSubview(subview)
    }
  }
  
  // MARK: - Setup layout
  
  func setupLayout() {
    missionNameLabel.snp.makeConstraints { make in
      make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
      make.leading.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().offset(-16)
      make.height.equalToSuperview().multipliedBy(0.25)
    }
    
    missionPatchImageView.snp.makeConstraints { make in
      make.top.equalTo(missionNameLabel.snp.bottom).offset(15)
      make.width.equalToSuperview().multipliedBy(0.5)
      make.centerX.equalToSuperview()
      make.height.equalTo(missionPatchImageView.snp.width)
    }
    
    dateLabel.snp.makeConstraints { make in
      make.top.equalTo(missionPatchImageView.snp.bottom).offset(15)
      make.leading.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().offset(-16)
      make.height.equalToSuperview().multipliedBy(0.2)
    }
  }
  
  // MARK: - Setup appearance
  
  func setupAppearance() {
    backgroundColor = .gray
    
    missionNameLabel.numberOfLines = 0
    missionNameLabel.textAlignment = .center
    missionNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
    missionNameLabel.backgroundColor = backgroundColor
    
    dateLabel.numberOfLines = 0
    dateLabel.textAlignment = .center
    dateLabel.font = UIFont.systemFont(ofSize: 12)
    dateLabel.backgroundColor = backgroundColor
    
    layer.cornerRadius = 10
    layer.masksToBounds = true
    
    missionPatchImageView.layer.cornerRadius = 10
    missionPatchImageView.layer.masksToBounds = true
  }
  
}

// MARK: - Public methods

extension RocketLaunchCell {
  
  func apply(viewModel: RocketLaunchCell.ViewModel) {
    missionNameLabel.text = viewModel.missionName
    dateLabel.text = viewModel.missionDate
    
    missionPatchImageView.kf.setImage(
      with: viewModel.missionPatchImageViewURL,
      placeholder: UIImage(named: "Cosmos"),
      options: [
        .scaleFactor(contentScaleFactor),
        .transition(.fade(1)),
        .cacheOriginalImage
      ])
  }
}

// MARK: - Extension String for cell reuseID/

private extension String {
  static let cell = "RocketLaunchCell"
}
