//
//  FlickerImageRouter.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 14.02.2024.
//

import ViperMcFlurry

final class FlickerImageRouter {
  
  // MARK: - Connections
  
  weak var transitionHandler: RamblerViperModuleTransitionHandlerProtocol?
  
}

// MARK: - FlickerImageRouterProtocol

extension FlickerImageRouter: FlickerImageRouterProtocol {
  
  func dismiss() {
    transitionHandler?.closeCurrentModule?(true)
  }
  
}
