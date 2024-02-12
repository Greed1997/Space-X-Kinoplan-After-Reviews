//
//  ListOfRocketsLaunchesRouter.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import ViperMcFlurry

// MARK: - ListOfRocketsLaunchesRouter
final class ListOfRocketsLaunchesRouter: ListOfRocketsLaunchesRouterInputProtocol {
  
  // MARK: - Connections
  weak var transitionHandler: RamblerViperModuleTransitionHandlerProtocol?
  
  // MARK: - Open RocketLaunchInfoVC
  func showRocketLaunchInfo(with index: Int) {
    let factory = RocketLaunchInfoAssembly(index: index)

    transitionHandler?.openModule?(usingFactory: factory, withTransitionBlock:{ sourceModuleTransitionHandler, destinationModuleTransititionHandler in
      guard let sourceVC = sourceModuleTransitionHandler as? UIViewController,
            let destinationVC = destinationModuleTransititionHandler as? UIViewController else { return }
      sourceVC.navigationController?.pushViewController(destinationVC, animated: true)
    }).thenChain { test in
//      print(type(of: test))
      return nil
    }
  }
}
