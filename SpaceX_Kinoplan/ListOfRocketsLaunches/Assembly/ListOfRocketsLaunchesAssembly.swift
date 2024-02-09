//
//  ListOfRocketsLaunchesAssembly.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import UIKit

// MARK: - ListOfRocketsLaunchesAssembly
final class ListOfRocketsLaunchesAssembly: ListOfRocketsLaunchesAssemblyProtocol {
  func createListOfRocketsLaunchesModule(vc: ListOfRocketLaunchesViewProtocol) {
    let networkService = NetworkService()
//    let cacheStorage = CacheStorage()
    let router = ListOfRocketsLaunchesRouter()
    let presenter = ListOfRocketsLaunchesPresenter()
    let interactor = ListOfRocketsLaunchesInteractor()
    
    presenter.router = router
    presenter.view = vc
    presenter.interactor = interactor
    
    interactor.output = presenter
    interactor.networkService = networkService
    
    vc.output = presenter
    
    router.transitionHandler = vc
    router.assemblyBuilderRocketLaunchInfo = RocketLaunchInfoAssembly()
  }
}
