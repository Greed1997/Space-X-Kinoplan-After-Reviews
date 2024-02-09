//
//  RocketLaunchInfoAssembly.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import ViperMcFlurry

// MARK: - RocketLaunchInfoAssembly
final class RocketLaunchInfoAssembly: NSObject, RamblerViperModuleFactoryProtocol {
  
  func instantiateModuleTransitionHandler() -> RamblerViperModuleTransitionHandlerProtocol? {
    let vc = RocketLaunchInfoViewController()
    let router = RocketLaunchInfoRouter()
    let presenter = RocketLaunchInfoPresenter()
    //    let interactor = RocketLaunchInteractor()
    
    presenter.router = router
    presenter.view = vc
    
    router.transitionHandler = vc
    
    return vc
  }
  
}

