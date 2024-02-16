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
  
  private var rocketLaunchInfoViewModel: RocketLaunchInfoViewModel!
  
  // MARK: - UI properties
  
  private var stackView              = UIStackView()
  private let missionNameLabel       = UILabel()
  private let missionPatchImageView  = UIImageView()
  private let dateLabel              = UILabel()
  private let youtubeVideoLinkButton = UIButton(type: .system)
  private let wikipediaLinkButton    = UIButton(type: .system)
  private let redditLinkButton       = UIButton(type: .system)
  private let articleLinkButton      = UIButton(type: .system)
  private let flickrImagesButton     = UIButton(type: .system)
  private let backButton             = UIButton(type: .system)
  
  // MARK: - viewDidLoad()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    embedViews()
    setupLayout()
    setupAppearance()
    setupBehaviour()
    
    output?.viewDidLoad()
  }
}

// MARK: - Setup view content

private extension RocketLaunchInfoViewController {
  
  // MARK: - Embed subviews for stackView
  
  func embedViews() {
    [
      missionNameLabel,
      missionPatchImageView,
      dateLabel,
      youtubeVideoLinkButton,
      wikipediaLinkButton,
      redditLinkButton,
      articleLinkButton,
      flickrImagesButton
    ].forEach { stackView.addArrangedSubview($0) }
    view.addSubview(stackView)
  }
  
  // MARK: - Setup layout
  
  func setupLayout() {
    
    stackView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.centerX.equalTo(view.snp.centerX)
      make.bottom.lessThanOrEqualTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20).priority(.high)
    }
    
    missionNameLabel.snp.makeConstraints { make in
      make.width.equalTo(view.safeAreaLayoutGuide.snp.width).multipliedBy(0.8)
    }
    
    missionPatchImageView.snp.makeConstraints { make in
      make.height.equalToSuperview().multipliedBy(0.15)
      make.width.equalTo(view.snp.height).multipliedBy(0.15)
    }
    
  }
  
  // MARK: - Setup appearance
  
  func setupAppearance() {
    view.backgroundColor = .darkGray
    
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.distribution = .equalSpacing
    stackView.spacing = 15
    
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
    backButton.titleLabel?.font         = UIFont.systemFont(ofSize: 18)
    backButton.semanticContentAttribute = .forceRightToLeft
  }
  
  // MARK: - Setup behavior
  
  func setupBehaviour() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    
    backButton.addTarget(
      self,
      action: #selector(onBackButtonItemButtonTapped),
      for: .touchUpInside
    )
    youtubeVideoLinkButton.addTarget(
      self,
      action: #selector(openYoutubeVideo),
      for: .touchUpInside
    )
    wikipediaLinkButton.addTarget(
      self,
      action: #selector(openWikipediaInfo),
      for: .touchUpInside
    )
    redditLinkButton.addTarget(
      self,
      action: #selector(openRedditInfo),
      for: .touchUpInside
    )
    articleLinkButton.addTarget(
      self,
      action: #selector(openArticleInfo),
      for: .touchUpInside
    )
    flickrImagesButton.addTarget(
      self,
      action: #selector(showlistOfFlickerImages),
      for: .touchUpInside
    )
  }
}

// MARK: - Objc buttons methods

private extension RocketLaunchInfoViewController {
  
  @objc func openYoutubeVideo() {
    output?.onYoutubeButtonTapped()
  }
  
  @objc func openWikipediaInfo() {
    output?.onWikiButtonTapped()
  }
  
  @objc func openRedditInfo() {
    output?.onRedditButtonTapped()
  }
  
  @objc func openArticleInfo() {
    output?.onArticleButtonTapped()
  }
  
  @objc func showlistOfFlickerImages() {
    output?.onFlickerImagesButtonTapped()
  }
  
  @objc func onBackButtonItemButtonTapped() {
    output?.onBackButtonTapped()
  }
  
}

// MARK: - RocketLaunchInfoViewProtocol

extension RocketLaunchInfoViewController: RocketLaunchInfoViewProtocol {
  
  func set(viewModel: RocketLaunchInfoViewModel) {
    missionNameLabel.text = viewModel.missionName
    dateLabel.text        = viewModel.missionDate
    missionPatchImageView.kf.setImage(with: viewModel.missionPatchImageViewURL)
    updateButtonAvailability(for: viewModel)
  }
  
}

// MARK: - Update UI elements embed & layout

private extension RocketLaunchInfoViewController {
  
  // MARK: - Hide/unhide UI elements
  
  func updateButtonAvailability(for viewModel: RocketLaunchInfoViewModel) {
    youtubeVideoLinkButton.isHidden = viewModel.youtubeLink == nil
    wikipediaLinkButton.isHidden = viewModel.wikiLink == nil
    redditLinkButton.isHidden = viewModel.redditLink == nil
    articleLinkButton.isHidden = viewModel.articleLink == nil
    flickrImagesButton.isHidden = viewModel.flickerImages?.isEmpty ?? true
  }
  
}
