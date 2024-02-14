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
  
  // MARK: - Properties
  
  var rocketLaunchInfoViewModel: RocketLaunchInfoViewModel!
  
  // MARK: - UI properties
  
  // General info
  
  private let missionNameLabel = UILabel()
  
  private let missionPatchImageView = UIImageView()
  
  private let dateLabel = UILabel()
  
  // Links
  
  private let youtubeVideoLinkButton = UIButton(type: .system)
  
  private let wikipediaLinkButton = UIButton(type: .system)
  
  private let redditLinkButton = UIButton(type: .system)
  
  private let articleLinkButton = UIButton(type: .system)
  
  private let flickrImagesButton = UIButton(type: .system)
  
  // Back button
  
  private let backButton = UIButton(type: .system)
  
  private lazy var newBackLeftBarButtonItem = UIBarButtonItem(customView: backButton)
  
  
  // MARK: - viewDidLoad()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    embedSubviews(subviews:
                    missionNameLabel,
                  missionPatchImageView,
                  dateLabel,
                  youtubeVideoLinkButton,
                  wikipediaLinkButton,
                  redditLinkButton,
                  articleLinkButton,
                  flickrImagesButton)
    
    setupLayout()
    setupAppearance()
    setupBehaviour()
    
    output?.viewDidLoad()
    
    
  }
}
// MARK: - Setup view content

private extension RocketLaunchInfoViewController {
  
  // MARK: - Embed subviews for stackView
  
  func embedSubviews(subviews: UIView...) {
    subviews.forEach { subview in
      view.addSubview(subview)
    }
  }
  
  // MARK: - Setup layout
  
  func setupLayout() {
    
    missionNameLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.width.equalTo(view.safeAreaLayoutGuide.snp.width).multipliedBy(0.8)
      make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
    }
    
    missionPatchImageView.snp.makeConstraints { make in
      make.top.equalTo(missionNameLabel.snp.bottom).offset(view.frame.height / 10)
      make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
      make.height.equalToSuperview().multipliedBy(0.15)
      make.width.equalTo(view.snp.height).multipliedBy(0.15)
    }
    
    youtubeVideoLinkButton.snp.makeConstraints { make in
      make.top.equalTo(missionPatchImageView.snp.bottom).offset(15)
      make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
    }
    
    wikipediaLinkButton.snp.makeConstraints { make in
      make.top.equalTo(youtubeVideoLinkButton.snp.bottom).offset(15)
      make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
    }
    
    redditLinkButton.snp.makeConstraints { make in
      make.top.equalTo(wikipediaLinkButton.snp.bottom).offset(15)
      make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
    }
    
    articleLinkButton.snp.makeConstraints { make in
      make.top.equalTo(redditLinkButton.snp.bottom).offset(15)
      make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
    }
    
    flickrImagesButton.snp.makeConstraints { make in
      make.top.equalTo(articleLinkButton.snp.bottom).offset(15)
      make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
    }
    
  }
  
  // MARK: - Setup appearance
  
  func setupAppearance() {
    
    view.backgroundColor = .darkGray
    
    missionNameLabel.numberOfLines      = 0
    missionNameLabel.textAlignment      = .center
    missionNameLabel.layer.cornerRadius = 10
    missionNameLabel.font               = UIFont.boldSystemFont(ofSize: 20)
    missionNameLabel.textColor          = .black
    missionNameLabel.backgroundColor    = .darkGray
    
    missionPatchImageView.contentMode = .scaleAspectFill
    
    
    dateLabel.backgroundColor    = .darkGray
    dateLabel.numberOfLines      = 0
    dateLabel.textAlignment      = .center
    dateLabel.layer.cornerRadius = 10
    dateLabel.font               = UIFont.systemFont(ofSize: 18)
    dateLabel.textColor          = .black
    
    youtubeVideoLinkButton.setTitle("Youtube", for: .normal)
    youtubeVideoLinkButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    
    wikipediaLinkButton.setTitle("Wikipedia", for: .normal)
    wikipediaLinkButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    
    redditLinkButton.setTitle("Reddit", for: .normal)
    redditLinkButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    
    articleLinkButton.setTitle("Article", for: .normal)
    articleLinkButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    
    flickrImagesButton.setTitle("Go to see images", for: .normal)
    flickrImagesButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    
    backButton.setTitle("Back", for: .normal)
    backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
    backButton.addTarget(self, action: #selector(backButtonItemButtonTapped), for: .touchUpInside)
    backButton.titleLabel?.font         = UIFont.systemFont(ofSize: 18)
    backButton.semanticContentAttribute = .forceRightToLeft
    
    navigationItem.leftBarButtonItem = newBackLeftBarButtonItem
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

// MARK: - Objc buttons methods

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
  
  func viewDidLoadFromOutput(rocketLaunchInfoViewModel: RocketLaunchInfoViewModel) {
    missionNameLabel.text = rocketLaunchInfoViewModel.missionName
    dateLabel.text        = rocketLaunchInfoViewModel.missionDate
    missionPatchImageView.kf.setImage(with: rocketLaunchInfoViewModel.missionPatchImageViewURL)
    updateButtonAvailability(for: rocketLaunchInfoViewModel)
    updateButtonConstraints(for: rocketLaunchInfoViewModel)
  }
  
  // MARK: - Hide/unhide UI elements
  
  func updateButtonAvailability(for rocketLaunchInfoViewModel: RocketLaunchInfoViewModel) {
    youtubeVideoLinkButton.isHidden = rocketLaunchInfoViewModel.youtubeLink == nil
    wikipediaLinkButton.isHidden    = rocketLaunchInfoViewModel.wikiLink == nil
    redditLinkButton.isHidden       = rocketLaunchInfoViewModel.redditLink == nil
    articleLinkButton.isHidden      = rocketLaunchInfoViewModel.articleLink == nil
    flickrImagesButton.isHidden     = rocketLaunchInfoViewModel.flickerImagesURLsStrings?.isEmpty ?? true
  }
  
  // MARK: - Update constraints with hide/unhide UI elements
  
  func updateButtonConstraints(for rocketLaunchInfoViewModel: RocketLaunchInfoViewModel) {
    
    var elements: [(UIView, Bool)] = [
      (missionNameLabel, true),
      (missionPatchImageView, true),
      (dateLabel, true),
      (youtubeVideoLinkButton, rocketLaunchInfoViewModel.youtubeLink != nil),
      (wikipediaLinkButton, rocketLaunchInfoViewModel.wikiLink       != nil),
      (redditLinkButton, rocketLaunchInfoViewModel.redditLink        != nil),
      (articleLinkButton, rocketLaunchInfoViewModel.articleLink      != nil),
      (flickrImagesButton, !(rocketLaunchInfoViewModel.flickerImagesURLsStrings?.isEmpty ?? true))
    ]
    
    if elements.map({ $0.1 == true }) == Array(repeating: true, count: elements.count) {
      return
    }
    
    var previousElement: UIView? = nil
    
    for (element, shouldBeVisible) in elements {
      if shouldBeVisible {
        element.snp.remakeConstraints { make in
          if let previous = previousElement {
            make.top.equalTo(previous.snp.bottom).offset(15)
          } else {
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
          }
          make.centerX.equalTo(view.snp.centerX)
          
          if element == missionNameLabel {
            make.width.equalTo(view.safeAreaLayoutGuide.snp.width).multipliedBy(0.8)
          } else if element == missionPatchImageView {
            make.height.equalToSuperview().multipliedBy(0.15)
            make.width.equalTo(view.snp.height).multipliedBy(0.15)
          }
        }
        previousElement = element
      }
    }
  }
  // MARK: - McFlurry needed function
  
  func instantiateModuleTransitionHandler() -> RamblerViperModuleTransitionHandlerProtocol? {
    return self
  }
}
