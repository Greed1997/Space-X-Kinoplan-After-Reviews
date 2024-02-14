//
//  RocketLaunchInfoViewProtocol.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import ViperMcFlurry

// MARK: - RocketLaunchInfoViewInputProtocol

protocol RocketLaunchInfoViewInputProtocol: AnyObject {
  func viewDidLoadFromOutput(rocketLaunchInfoViewModel: RocketLaunchInfoViewModel)
  func updateButtonAvailability(for rocketLaunchInfoViewModel: RocketLaunchInfoViewModel)
  func updateButtonConstraints(for rocketLaunchInfoViewModel: RocketLaunchInfoViewModel)
}

// MARK: - RocketLaunchInfoViewOutputProtocol

protocol RocketLaunchInfoOutputProtocol: AnyObject, RamblerViperModuleInput {
  init(
    router: RocketLaunchInfoRouterProtocol,
    view: RocketLaunchInfoViewInputProtocol
  )
  func viewDidLoad()
  func youtubeButtonTapped()
  func wikiButtonTapped()
  func redditButtonTapped()
  func articleButtonTapped()
  func flickerImagesButtonTapped()
  func popToRoot()
  func setVariable(for rocketLaunch: RocketLaunch)
}

// MARK: - RocketLaunchInfoViewProtocol

protocol RocketLaunchInfoViewProtocol: AnyObject, RocketLaunchInfoViewInputProtocol, RamblerViperModuleTransitionHandlerProtocol {
  var output: RocketLaunchInfoOutputProtocol? { get set }
}

// MARK: - RocketLaunchInfoViewModel

struct RocketLaunchInfoViewModel: Hashable {
  
  let missionName: String?
  let missionPatchImageViewURL: URL?
  let missionDate: String?
  
  let youtubeLink: String?
  let wikiLink: String?
  let redditLink: String?
  let articleLink: String?
  let flickerImagesURLsStrings: [String]?
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(missionName)
  }
  
  static func == (lhs: RocketLaunchInfoViewModel, rhs: RocketLaunchInfoViewModel) -> Bool {
    lhs.missionName == rhs.missionName &&
    lhs.missionPatchImageViewURL == rhs.missionPatchImageViewURL &&
    lhs.missionDate == rhs.missionDate
  }
}
