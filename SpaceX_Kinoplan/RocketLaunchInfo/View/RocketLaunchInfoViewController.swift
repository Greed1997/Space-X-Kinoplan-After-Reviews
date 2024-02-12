//
//  RocketLaunchInfoViewController.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 25.01.2024.
//

import ViperMcFlurry
import SnapKit
import Kingfisher

// MARK: - RocketLaunchInfoViewController
final class RocketLaunchInfoViewController: UIViewController {
  
  // MARK: - Connections
  var output: RocketLaunchInfoOutputProtocol?
  
 
  // MARK: - UI properties
  private let stackView = UIStackView()
  private lazy var missionNameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.layer.cornerRadius = 10
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.textColor = .black
    return label
  }()
  
  private lazy var missionPatchImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  private lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.layer.cornerRadius = 10
    label.font = UIFont.systemFont(ofSize: 18)
    label.textColor = .black
    return label
  }()
  
  private lazy var youtubeVideoLinkButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Youtube", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    return button
  }()
  
  private lazy var wikipediaLinkButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Wikipedia", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    return button
  }()
  
  private lazy var redditLinkButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Reddit", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    return button
  }()
  
  private lazy var articleLinkButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Article", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    return button
  }()
  
  private lazy var flickrImagesButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Go to see images", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    return button
  }()
  
  private lazy var newBackLeftBarButtonItem: UIBarButtonItem = {
    let backButton = UIButton(type: .system)
    backButton.setTitle("Back", for: .normal)
    backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
    backButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
    backButton.addTarget(self, action: #selector(backButtonItemButtonTapped), for: .touchUpInside)
    backButton.semanticContentAttribute = .forceRightToLeft
    return UIBarButtonItem(customView: backButton)
  }()
  // MARK: - viewDidLoad()
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupStackView(subviews:
                    missionNameLabel,
                   missionPatchImageView,
                   dateLabel,
                   youtubeVideoLinkButton,
                   wikipediaLinkButton,
                   redditLinkButton,
                   articleLinkButton,
                   flickrImagesButton
    )
    setupLayout()
    setupAppearance()
    setupBehaviour()
    output?.viewDidLoad()

    navigationItem.leftBarButtonItem = newBackLeftBarButtonItem
  }
}
// MARK: - Setup view content
private extension RocketLaunchInfoViewController {
  // MARK: - Setup stackview
  func setupStackView(subviews: UIView...) {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = CGFloat(view.frame.height / 20)
    embedSubviews(for: stackView, add: subviews)
    
    view.addSubview(stackView)
  }
  
  // MARK: - Embed subviews for stackView
  func embedSubviews(for stackView: UIStackView, add subviews: [UIView]) {
    subviews.forEach { subview in
      stackView.addArrangedSubview(subview)
    }
  }
  
  // MARK: - Setup layout
  func setupLayout() {
    stackView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(-16)
      make.center.equalToSuperview()
      make.width.lessThanOrEqualToSuperview().offset(-16)
      make.height.lessThanOrEqualToSuperview().offset(-16)
    }
    missionPatchImageView.snp.makeConstraints { make in
      make.height.equalToSuperview().multipliedBy(0.15)
      make.width.equalTo(view.snp.height).multipliedBy(0.15)
    }
    missionNameLabel.snp.makeConstraints { make in
      make.width.equalTo(stackView.snp.width).multipliedBy(0.8)
    }
  }
  
  // MARK: - Setup appearance
  func setupAppearance() {
    view.backgroundColor = .darkGray
    missionNameLabel.backgroundColor = .darkGray
    dateLabel.backgroundColor = .darkGray
  }
  
  // MARK: - Setup behavior
  func setupBehaviour() {
    youtubeVideoLinkButton.addTarget(self, action: #selector(openYoutubeVideo), for: .touchUpInside)
    wikipediaLinkButton.addTarget(self, action: #selector(openWikipediaInfo), for: .touchUpInside)
    redditLinkButton.addTarget(self, action: #selector(openRedditInfo), for: .touchUpInside)
    articleLinkButton.addTarget(self, action: #selector(openArticleInfo), for: .touchUpInside)
    flickrImagesButton.addTarget(self, action: #selector(goTolistOfFlickerImagesVC), for: .touchUpInside)
  }
}

// MARK: - Objc button methods
private extension RocketLaunchInfoViewController {
  @objc
  func openYoutubeVideo() {
    output?.youtubeButtonTapped()
  }
  @objc
  func openWikipediaInfo() {
    output?.wikiButtonTapped()
  }
  @objc
  func openRedditInfo() {
    output?.redditButtonTapped()
  }
  @objc
  func openArticleInfo() {
    output?.articleButtonTapped()
  }
  @objc
  func goTolistOfFlickerImagesVC() {
    output?.flickerImagesButtonTapped()
  }
  @objc
  func backButtonItemButtonTapped() {
    output?.popToRoot()
  }
}
// MARK: - RocketLaunchInfoViewProtocol
extension RocketLaunchInfoViewController: RocketLaunchInfoViewProtocol {
  func viewDidLoadFromOutput(
    missionNameText: String,
    missionPatchURL: URL,
    dateText: String,
    rocketLaunchInfo: RocketLaunchInfo) {
      missionNameLabel.text = missionNameText
      dateLabel.text = dateText
      missionPatchImageView.kf.setImage(with: missionPatchURL)
      updateButtonAvailability(for: rocketLaunchInfo)
    }
  // MARK: - Is hidden ui elements
  func updateButtonAvailability(for rocketLaunchInfo: RocketLaunchInfo) {
    youtubeVideoLinkButton.isHidden = rocketLaunchInfo.links?.youtubeId == nil
    wikipediaLinkButton.isHidden = rocketLaunchInfo.links?.wikipedia == nil
    redditLinkButton.isHidden = rocketLaunchInfo.links?.redditLaunch == nil
    articleLinkButton.isHidden = rocketLaunchInfo.links?.articleLink == nil
    }
  func instantiateModuleTransitionHandler() -> RamblerViperModuleTransitionHandlerProtocol? {
    return self
  }
}
