//
//  ListOfRocketsLaunchesRouter.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import ViperMcFlurry

final class ListOfRocketsLaunchesRouter {
  
  // MARK: - Connections
  
  weak var transitionHandler: RamblerViperModuleTransitionHandlerProtocol?
  
}

// MARK: - ListOfRocketsLaunchesRouterInputProtocol

extension ListOfRocketsLaunchesRouter: ListOfRocketsLaunchesRouterProtocol {
  
  func showRocketLaunchInfo(with rocketLaunch: RocketLaunch) {
    
    let factory = RocketLaunchInfoAssembly()
    
    transitionHandler?.openModule?(usingFactory: factory, withTransitionBlock:{ sourceModuleTransitionHandler, destinationModuleTransititionHandler in
      
      guard let sourceVC = sourceModuleTransitionHandler as? UIViewController,
            let destinationVC = destinationModuleTransititionHandler as? RocketLaunchInfoViewController else { return }
      
      sourceVC.navigationController?.pushViewController(destinationVC, animated: true)
    }).thenChain { moduleInput in
      
      (moduleInput as? RocketLaunchInfoOutputProtocol)?.setVariable(rocketLaunch)
      
      return nil
    }
  }
  
}
