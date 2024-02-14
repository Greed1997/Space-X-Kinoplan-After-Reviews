//
//  RocketLaunchInfoRouter.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import ViperMcFlurry

//MARK: - RocketLaunchInfoRouter

final class RocketLaunchInfoRouter: RocketLaunchInfoRouterProtocol {
  
  // MARK: - Connections
  
  weak var transitionHandler: RamblerViperModuleTransitionHandlerProtocol?
  
  // MARK: - Pop to root
  
  func popToRoot() {
    transitionHandler?.closeCurrentModule?(true)
  }
  
  // MARK: - Push flicker images view controller
  
  func showFlickerImagesVC(rocketLaunch: RocketLaunch) {
    let factory = ListOfFlickerImagesAssembly()
    
    transitionHandler?.openModule?(usingFactory: factory, withTransitionBlock: { sourceModuleTransitionHandler, destinationModuleTransititionHandler in
      
      guard let sourceVC = sourceModuleTransitionHandler as? UIViewController,
            let destinationVC = destinationModuleTransititionHandler as? ListOfFlickerImagesViewController else { return }
      
      sourceVC.navigationController?.pushViewController(destinationVC, animated: true)
    }).thenChain({ moduleInput in
      
      guard let destinationInput = moduleInput as? ListOfFlickerImagesViewOutputProtocol else { return nil }
      
      destinationInput.setVariable(for: rocketLaunch)
      return nil
    })
  }
}
