//
//  ListOfFlickerImagesAssembly.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import ViperMcFlurry

final class ListOfFlickerImagesAssembly: NSObject, RamblerViperModuleFactoryProtocol {
  
  func instantiateModuleTransitionHandler() -> RamblerViperModuleTransitionHandlerProtocol? {
    let vc = ListOfFlickerImagesViewController()
    let router = ListOfFlickerImagesRouter()
    let presenter = ListOfFlickerImagesPresenter(view: vc, router: router)
    
    vc.output = presenter
    
    router.transitionHandler = vc
    return vc
  }
  
}
