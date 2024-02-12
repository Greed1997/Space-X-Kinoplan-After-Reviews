//
//  ListOfRocketsLaunchesAssembly.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import ViperMcFlurry

final class ListOfRocketsLaunchesAssembly: NSObject, RamblerViperModuleFactoryProtocol {
  
  func instantiateModuleTransitionHandler() -> RamblerViperModuleTransitionHandlerProtocol? {
    let viewController = ListOfRocketsLaunchesViewController()
    
    let router = ListOfRocketsLaunchesRouter()
    router.transitionHandler = viewController
    
    let networkService = NetworkService()
    let cacheStorage = KingFisherImageCacheStorage()
    
    let interactor = ListOfRocketsLaunchesInteractor(
      networkService: networkService,
      cacheStorage: cacheStorage
    )
    
    let presenter = ListOfRocketsLaunchesPresenter(
      view: viewController,
      interactor: interactor,
      router: router
    )
    
    viewController.output = presenter
    interactor.output = presenter
    
    return viewController
  }
  
}
