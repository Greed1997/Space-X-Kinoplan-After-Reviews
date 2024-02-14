//
//  ListOfFlickerImagesRouter.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import ViperMcFlurry

//MARK: - ListOfFlickerImagesRouter

final class ListOfFlickerImagesRouter: ListOfFlickerImagesRouterProtocol {
  
  // MARK: - Connection
  
  weak var transitionHandler: RamblerViperModuleTransitionHandlerProtocol?

  // MARK: - Go to selected flicker image view controller
  
  func goToViewControllerWithSelectedFlickerImage(flickerImageURL: URL) {
    
    let factory = FlickerImageViewAssembly()
    
    transitionHandler?.openModule?(usingFactory: factory, withTransitionBlock: { sourceModuleTransitionHandler, destinationModuleTransitionHandler in
      
      guard let sourceVC = sourceModuleTransitionHandler as? UIViewController,
            let destinationVC = destinationModuleTransitionHandler as? FlickerImageViewController else { return }
      
      sourceVC.present(destinationVC, animated: true)
    }).thenChain({ moduleInput in
      
      guard let destinationInput = moduleInput as? FlickerImageViewOutputProtocol else { return nil }
      
      destinationInput.setVariable(for: flickerImageURL)
      return nil
    })
  }
  
  // MARK: - Go back to the rocket launch info
  
  func goToRocketLaunchInfo() {
    transitionHandler?.closeCurrentModule?(true)
  }
  
}
