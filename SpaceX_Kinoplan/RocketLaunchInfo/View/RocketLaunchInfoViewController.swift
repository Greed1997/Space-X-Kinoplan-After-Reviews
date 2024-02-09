//
//  RocketLaunchInfoViewController.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 25.01.2024.
//

import ViperMcFlurry
import SnapKit

// MARK: - RocketLaunchInfoViewController
final class RocketLaunchInfoViewController: UIViewController {
  
  // MARK: - UI properties
  let stackView = UIStackView()
  private lazy var missionNameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.layer.cornerRadius = 10
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.backgroundColor = view.backgroundColor
    label.textColor = .black
    return label
  }()
  private lazy var missionPatchImageView: RocketLauncheImageView = {
    let imageView = RocketLauncheImageView()
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  private lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.layer.cornerRadius = 10
    label.font = UIFont.systemFont(ofSize: 18)
    label.backgroundColor = view.backgroundColor
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
  
  // MARK: - Connections
  var output: RocketLaunchInfoOutputProtocol?
  
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
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview()
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
}
// MARK: - RocketLaunchInfoViewProtocol
extension RocketLaunchInfoViewController: RocketLaunchInfoViewProtocol {
  
  func viewDidLoadFromOutput(rocketLaunch: RocketLaunch, 
                             missionNameText: String,
                             dateText: String,
                             image: UIImage?) {
    updateButtonAvailability(for: rocketLaunch)
    missionNameLabel.text = missionNameText
    dateLabel.text = dateText
    missionPatchImageView.image = image
  }
  func updateButtonAvailability(for rocketLaunch: RocketLaunch) {
    //        youtubeVideoLinkButton.isHidden = rocketLaunch.links?.youtubeId == nil
    //        wikipediaLinkButton.isHidden = rocketLaunch.links?.wikipedia == nil
    //        redditLinkButton.isHidden = rocketLaunch.links?.redditLaunch == nil
    //        articleLinkButton.isHidden = rocketLaunch.links?.articleLink == nil
    //        if rocketLaunch.links?.flickrImages == Optional([]) || rocketLaunch.links?.flickrImages == nil {
    //            flickrImagesButton.isHidden = true
    //        } else {
    //            flickrImagesButton.isHidden = false
    //        }
    //        if rocketLaunch.links?.missionPatch == nil || rocketLaunch.links?.missionPatch == "" {
    //            missionPatchImageView.isHidden = true
    //        } else {
    //            missionPatchImageView.isHidden = false
    //        }
    //        print(rocketLaunch.links?.missionPatch ?? 1234)
  }
}
