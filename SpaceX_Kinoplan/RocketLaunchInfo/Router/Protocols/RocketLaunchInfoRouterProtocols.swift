//
//  RocketLaunchInfoRouterProtocols.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import ViperMcFlurry

// MARK: - RocketLaunchInfoRouterProtocol
protocol RocketLaunchInfoRouterProtocol: AnyObject {
  var transitionHandler: RamblerViperModuleTransitionHandlerProtocol? { get set }
//  var listOfFlickerImagesAssembly: ListOfRocketsLaunchesAssemblyProtocol? { get set }
  func popToRoot()
  func showFlickerImagesVC(rocketLaunchInfo: RocketLaunchInfo)
}
