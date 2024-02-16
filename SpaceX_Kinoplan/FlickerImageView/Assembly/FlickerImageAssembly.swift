//
//  FlickerImageAssembly.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 14.02.2024.
//

import ViperMcFlurry

final class FlickerImageAssembly: NSObject, RamblerViperModuleFactoryProtocol {
  
  func instantiateModuleTransitionHandler() -> RamblerViperModuleTransitionHandlerProtocol? {
    let viewController = FlickerImageViewController()
    
    let router = FlickerImageRouter()
    router.transitionHandler = viewController
    
    let presenter = FlickerImagePresenter(
      view: viewController, 
      router: router
    )
    
    viewController.output = presenter
    
    return viewController
  }
  
}
