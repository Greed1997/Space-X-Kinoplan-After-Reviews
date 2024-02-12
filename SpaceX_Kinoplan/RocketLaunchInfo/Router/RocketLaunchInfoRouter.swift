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
  
  func showFlickerImagesVC(rocketLaunchInfo: RocketLaunchInfo) {
    let factory = ListOfFlickerImagesAssembly(rocketLaunchInfo: rocketLaunchInfo)
    
    transitionHandler?.openModule?(usingFactory: factory, withTransitionBlock: { sourceModuleTransitionHandler, destinationModuleTransititionHandler in
      guard let sourceVC = sourceModuleTransitionHandler as? UIViewController,
            let destinationVC = destinationModuleTransititionHandler as? UIViewController else { return }
      sourceVC.navigationController?.pushViewController(destinationVC, animated: true)
    }).thenChain({ test in
      return nil
    })
  }
  
}
