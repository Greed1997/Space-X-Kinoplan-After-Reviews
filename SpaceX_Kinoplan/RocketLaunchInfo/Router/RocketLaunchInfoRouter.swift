//
//  RocketLaunchInfoRouter.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import ViperMcFlurry

final class RocketLaunchInfoRouter {
  
  // MARK: - Connections
  
  weak var transitionHandler: RamblerViperModuleTransitionHandlerProtocol?
  
}

// MARK: - RocketLaunchInfoRouterProtocol

extension RocketLaunchInfoRouter: RocketLaunchInfoRouterProtocol {
  
  func dismiss() {
    transitionHandler?.closeCurrentModule?(true)
  }
  
  func showFlickerImages(rocketLaunch: RocketLaunch) {
    let factory = ListOfFlickerImagesAssembly()
    
    transitionHandler?.openModule?(
      usingFactory: factory,
      withTransitionBlock: { sourceModuleTransitionHandler, destinationModuleTransititionHandler in
        
        guard let sourceVC = sourceModuleTransitionHandler as? UIViewController,
              let destinationVC = destinationModuleTransititionHandler as? ListOfFlickerImagesViewController else { return }
        
        sourceVC.navigationController?.pushViewController(destinationVC, animated: true)
      }).thenChain({ moduleInput in
        
        (moduleInput as? ListOfFlickerImagesViewOutputProtocol)!.setVariable(for: rocketLaunch)
        
        return nil
      })
  }
  
}
