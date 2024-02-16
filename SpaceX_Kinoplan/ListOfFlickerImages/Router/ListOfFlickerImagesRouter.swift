//
//  ListOfFlickerImagesRouter.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import ViperMcFlurry

final class ListOfFlickerImagesRouter {
  
  // MARK: - Connection
  
  weak var transitionHandler: RamblerViperModuleTransitionHandlerProtocol?
  
}

// MARK: - ListOfFlickerImagesRouterProtocol

extension ListOfFlickerImagesRouter: ListOfFlickerImagesRouterProtocol {
  
  func presentFlickerImageModule(flickerImageURL: URL) {
    
    let factory = FlickerImageAssembly()
    
    transitionHandler?.openModule?(
      usingFactory: factory,
      withTransitionBlock: { sourceModuleTransitionHandler, destinationModuleTransitionHandler in
        
        guard let sourceVC = sourceModuleTransitionHandler as? UIViewController,
              let destinationVC = destinationModuleTransitionHandler as? FlickerImageViewController else { return }
        
        sourceVC.present(destinationVC, animated: true)
      }).thenChain({ moduleInput in
        
        (moduleInput as? FlickerImageViewOutputProtocol)?.setVariable(flickerImageURL)
        
        return nil
      })
    
  }
  
  func dismiss() {
    transitionHandler?.closeCurrentModule?(true)
  }
  
}
