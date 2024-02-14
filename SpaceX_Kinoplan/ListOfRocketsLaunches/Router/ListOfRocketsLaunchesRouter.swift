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
  
  func showRocketLaunchInfo(with rocketLaunch: RocketLaunch) {
    
    let factory = RocketLaunchInfoAssembly()

    transitionHandler?.openModule?(usingFactory: factory, withTransitionBlock:{ sourceModuleTransitionHandler, destinationModuleTransititionHandler in
      
      guard let sourceVC = sourceModuleTransitionHandler as? UIViewController,
            let destinationVC = destinationModuleTransititionHandler as? RocketLaunchInfoViewController else { return }
      
      sourceVC.navigationController?.pushViewController(destinationVC, animated: true)
    }).thenChain { moduleInput in
      
      guard let destinationInput = moduleInput as? RocketLaunchInfoOutputProtocol else { return nil }
      
      destinationInput.setVariable(for: rocketLaunch)
      return nil
    }
  }
}
