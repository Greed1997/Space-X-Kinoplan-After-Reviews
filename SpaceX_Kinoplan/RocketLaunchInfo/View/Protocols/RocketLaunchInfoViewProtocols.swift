//
//  RocketLaunchInfoViewProtocol.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import ViperMcFlurry

// MARK: - RocketLaunchInfoViewInputProtocol
protocol RocketLaunchInfoViewInputProtocol: AnyObject {
  func viewDidLoadFromOutput(missionNameText: String, missionPatchURL: URL, dateText: String, rocketLaunchInfo: RocketLaunchInfo)
  func updateButtonAvailability(for rocketLaunchInfo: RocketLaunchInfo)
}
// MARK: - RocketLaunchInfoViewOutputProtocol
protocol RocketLaunchInfoOutputProtocol: AnyObject {
  init(router: RocketLaunchInfoRouterProtocol, view: RocketLaunchInfoViewInputProtocol)
  func viewDidLoad()
  func youtubeButtonTapped()
  func wikiButtonTapped()
  func redditButtonTapped()
  func articleButtonTapped()
  func flickerImagesButtonTapped()
  func popToRoot()
}
// MARK: - RocketLaunchInfoViewProtocol
protocol RocketLaunchInfoViewProtocol: AnyObject, RocketLaunchInfoViewInputProtocol, RamblerViperModuleTransitionHandlerProtocol {
  var output: RocketLaunchInfoOutputProtocol? { get set }
}
