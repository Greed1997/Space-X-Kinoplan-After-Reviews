//
//  RocketLaunchInfoViewProtocol.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import ViperMcFlurry

// MARK: - RocketLaunchInfoViewInputProtocol

protocol RocketLaunchInfoViewInputProtocol: AnyObject {
  func set(viewModel: RocketLaunchInfoViewModel)
}

// MARK: - RocketLaunchInfoViewOutputProtocol

protocol RocketLaunchInfoOutputProtocol: AnyObject, RamblerViperModuleInput {
  func viewDidLoad()
  func onYoutubeButtonTapped()
  func onWikiButtonTapped()
  func onRedditButtonTapped()
  func onArticleButtonTapped()
  func onFlickerImagesButtonTapped()
  func dismiss()
  func setVariable(_ rocketLaunch: RocketLaunch)
}

// MARK: - RocketLaunchInfoViewProtocol

protocol RocketLaunchInfoViewProtocol: AnyObject, RocketLaunchInfoViewInputProtocol, RamblerViperModuleTransitionHandlerProtocol {
  var output: RocketLaunchInfoOutputProtocol? { get set }
}

// MARK: - RocketLaunchInfoViewModel

struct RocketLaunchInfoViewModel {
  
  let missionName: String
  let missionPatchImageViewURL: URL?
  let missionDate: String
  
  let youtubeLink: String?
  let wikiLink: String?
  let redditLink: String?
  let articleLink: String?
  let flickerImages: [String]?
  
}
