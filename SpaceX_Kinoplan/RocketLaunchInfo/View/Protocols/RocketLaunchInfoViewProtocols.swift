//
//  RocketLaunchInfoViewProtocol.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import UIKit
import ViperMcFlurry

// MARK: - RocketLaunchInfoViewInputProtocol
protocol RocketLaunchInfoViewInputProtocol: AnyObject {
  
}
// MARK: - RocketLaunchInfoViewOutputProtocol
protocol RocketLaunchInfoOutputProtocol: AnyObject {
    func viewDidLoad()
    func youtubeButtonTapped()
    func wikiButtonTapped()
    func redditButtonTapped()
    func articleButtonTapped()
    func flickerImagesButtonTapped()
}
// MARK: - RocketLaunchInfoViewProtocol
protocol RocketLaunchInfoViewProtocol: AnyObject, RocketLaunchInfoViewInputProtocol, RamblerViperModuleTransitionHandlerProtocol {
  func viewDidLoadFromOutput(rocketLaunch: RocketLaunch, missionNameText: String, dateText: String, image: UIImage?)
  func updateButtonAvailability(for rocketLaunch: RocketLaunch)
}
