//
//  ListOfRocketsLaunchesRouter.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import ViperMcFlurry

// MARK: - ListOfRocketsLaunchesRouter
final class ListOfRocketsLaunchesRouter: ListOfRocketsLaunchesRouterInputProtocol {
  
  // MARK: - Properties
  var assemblyBuilderRocketLaunchInfo: RocketLaunchInfoAssembly?
  // MARK: - Connections
  weak var transitionHandler: RamblerViperModuleTransitionHandlerProtocol?
  
  // MARK: - Open RocketLaunchInfoVC
  func showRocketLaunchInfo(with rocketLaunch: RocketLaunch) {
    let vc = RocketLaunchInfoViewController()
    
    
    //assemblyBuilderRocketLaunchInfo?.createRocketLaunchInfoModule(vc: vc, rocketLaunchInfoModel: RocketLaunchInfoModel())
    
    let factory = RocketLaunchInfoAssembly()
    transitionHandler?.openModule?(usingFactory: factory, withTransitionBlock:{ sourceModuleTransitionHandler, destinationModuleTransititionHandler in
      print(1)
      guard let sourceVC = sourceModuleTransitionHandler as? UIViewController,
            let destinationVC = destinationModuleTransititionHandler as? UIViewController else { return }
      print(2)
      sourceVC.navigationController?.pushViewController(destinationVC, animated: true)
    }).thenChain { test in
      
      print(type(of: test))
      return nil
    }
  }
  
}
