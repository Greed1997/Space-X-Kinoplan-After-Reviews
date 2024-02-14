//
//  ListOfRocketsLaunchesRouterProtocols.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import ViperMcFlurry

protocol ListOfRocketsLaunchesRouterInputProtocol: AnyObject {
  var transitionHandler: RamblerViperModuleTransitionHandlerProtocol? { get set }
  
  func showRocketLaunchInfo(with rocketLaunch: RocketLaunch)
}

