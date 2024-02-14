//
//  FlickerImageViewRouter.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 14.02.2024.
//

import ViperMcFlurry

// MARK: - FlickerImageViewRouter

final class FlickerImageViewRouter: FlickerImageViewRouterProtocol {
  
  // MARK: - Connections
  
  weak var transitionHandler: RamblerViperModuleTransitionHandlerProtocol?
  
  // MARK: - Go to list of flicker images view controller
  
  func goToListOfFlickerImages() {
    transitionHandler?.closeCurrentModule?(true)
  }
  
}
