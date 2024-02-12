//
//  RocketLaunchInfoAssembly.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import ViperMcFlurry

// MARK: - RocketLaunchInfoAssembly
final class RocketLaunchInfoAssembly: NSObject, RamblerViperModuleFactoryProtocol {
  
  // MARK: - Properties
  let index: Int?
  
  // MARK: - Init
  init(index: Int? = nil) {
    self.index = index
  }
  
  func instantiateModuleTransitionHandler() -> RamblerViperModuleTransitionHandlerProtocol? {
    let networkService = NetworkService()
    
    let vc = RocketLaunchInfoViewController()
    let router = RocketLaunchInfoRouter()
    let presenter = RocketLaunchInfoPresenter(router: router, view: vc)
    let interactor = RocketLaunchInfoInteractor(output: presenter, networkService: networkService)
    
//    presenter.router = router
    // Изменить сувание по аналогии с ListOfRocket
    vc.output = presenter
    presenter.index = index
    presenter.interactor = interactor
    router.transitionHandler = vc
    return vc
  }
  
}

