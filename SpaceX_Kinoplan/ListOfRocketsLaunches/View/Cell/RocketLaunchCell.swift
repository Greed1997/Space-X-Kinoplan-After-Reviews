//
//  RocketLaunchCell.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 25.01.2024.
//

import UIKit
import Kingfisher
import SnapKit

// MARK: - Rocket launch cell model
struct RocketLaunchCellModel: Hashable {
  let missionName: String?
  let missionPatchImageViewURL: URL?
  let missionDate: String?
}

// MARK: - RocketLaunchCell
final class RocketLaunchCell: UICollectionViewCell, SelfConfiguringCell {
  
  // MARK: - Reuse ID
  static var reuseID: String {
    "RocketLaunchCell"
  }
  
  // MARK: - UI Properties
  private lazy var missionNameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.backgroundColor = backgroundColor
    label.font = UIFont.boldSystemFont(ofSize: 16)
    return label
  }()
  private lazy var missionPatchImageView: RocketLauncheImageView = {
    let imageView = RocketLauncheImageView()
    return imageView
  }()
  private lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textAlignment = .center
    label.backgroundColor = backgroundColor
    label.font = UIFont.systemFont(ofSize: 12)
    return label
  }()
  
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
    embedViews(subviews: missionNameLabel, missionPatchImageView, dateLabel)
    setupLayout()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configure cell
  func configure<U>(with value: U) where U : Hashable {
    guard let value = value as? RocketLaunchCellModel else { return }
    missionNameLabel.text = value.missionName
    dateLabel.text = value.missionDate
    missionPatchImageView.kf.setImage(with: value.missionPatchImageViewURL)
  }
}
// MARK: - Setup cell content
private extension RocketLaunchCell {
  
  // MARK: - Embed Views
  func embedViews(subviews: UIView...) {
    subviews.forEach { subview in
      subview.translatesAutoresizingMaskIntoConstraints = false
      addSubview(subview)
    }
  }
  
  // MARK: - Setup layout
  func setupLayout() {
    missionNameLabel.snp.makeConstraints { make in
      make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
      make.leading.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().offset(-16)
      make.height.equalToSuperview().multipliedBy(0.2)
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
}
