//
//  ListOfFlickerImagesAssembly.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import ViperMcFlurry

// MARK: - ListOfFlickerImagesAssembly
final class ListOfFlickerImagesAssembly: NSObject, RamblerViperModuleFactoryProtocol {
  
  // MARK: - Properties
  let rocketLaunchInfo: RocketLaunchInfo?
  
  // MARK: - Init
  init(rocketLaunchInfo: RocketLaunchInfo?) {
    self.rocketLaunchInfo = rocketLaunchInfo
  }
  
  func instantiateModuleTransitionHandler() -> RamblerViperModuleTransitionHandlerProtocol? {
    let vc = ListOfFlickerImagesViewController()
    let router = ListOfFlickerImagesRouter()
    let presenter = ListOfFlickerImagesPresenter(view: vc, router: router, rocketLaunchInfo: rocketLaunchInfo)
    
    vc.output = presenter
    
    router.transitionHandler = vc
    return vc
  }
  
}
