//
//  ListOfRocketsLaunchesRouterProtocols.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import ViperMcFlurry

// MARK: - ListOfRocketsLaunchesRouterInputProtocol
protocol ListOfRocketsLaunchesRouterInputProtocol: AnyObject {
  var transitionHandler: RamblerViperModuleTransitionHandlerProtocol? { get set }
//  var assemblyBuilderRocketLaunchInfo: RocketLaunchInfoAssembly? { get set }
//  var presentedViewController: UIViewController? { get }
  func showRocketLaunchInfo(with index: Int)
}

