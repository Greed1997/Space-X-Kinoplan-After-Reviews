//
//  FlickerImageViewAssembly.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 14.02.2024.
//

import ViperMcFlurry

final class FlickerImageViewAssembly: NSObject, RamblerViperModuleFactoryProtocol {
  
  
  func instantiateModuleTransitionHandler() -> RamblerViperModuleTransitionHandlerProtocol? {
    
    let viewController = FlickerImageViewController()
    
    let router = FlickerImageViewRouter()
    router.transitionHandler = viewController
    
    let presenter = FlickerImageViewPresenter(
      router: router,
      view: viewController
    )
    
    viewController.output = presenter
    
    return viewController
  }
  
  
  
}
