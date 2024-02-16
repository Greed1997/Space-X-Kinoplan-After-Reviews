//
//  RocketLaunchInfoAssembly.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import ViperMcFlurry

final class RocketLaunchInfoAssembly: NSObject, RamblerViperModuleFactoryProtocol {
  
  func instantiateModuleTransitionHandler() -> RamblerViperModuleTransitionHandlerProtocol? {
    
    let viewController = RocketLaunchInfoViewController()
    
    let router = RocketLaunchInfoRouter()
    router.transitionHandler = viewController
    
    let presenter = RocketLaunchInfoPresenter(
      view: viewController,
      router: router
    )
    
    viewController.output = presenter
    
    return viewController
    
  }
  
}

