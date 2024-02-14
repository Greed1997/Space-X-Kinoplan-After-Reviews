//
//  RocketLaunchInfoRouterProtocols.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import ViperMcFlurry

protocol RocketLaunchInfoRouterProtocol: AnyObject {
  var transitionHandler: RamblerViperModuleTransitionHandlerProtocol? { get set }
  func showFlickerImagesVC(rocketLaunch: RocketLaunch)
  func popToRoot()
}
