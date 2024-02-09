//
//  ListOfRocketsLaunchesViewControllerInputProtocol.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import ViperMcFlurry

// MARK: - ListOfRocketsLaunchesViewInputProtocol
protocol ListOfRocketsLaunchesViewInputProtocol: AnyObject {
    func reloadCollectionView(rocketLaunchCellModels: [RocketLaunchCellModel])
}
// MARK: - ListOfRocketsLaunchesViewControllerOutputProtocol
protocol ListOfRocketsLaunchesViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func dataFetched(rocketLaunches: [RocketLaunch])
    func getSelectedRocketLaunch(index: Int)
}

// MARK: - ListOfRocketLaunchesViewProtocol
protocol ListOfRocketLaunchesViewProtocol: AnyObject, ListOfRocketsLaunchesViewInputProtocol, RamblerViperModuleTransitionHandlerProtocol {
  var output: ListOfRocketsLaunchesViewOutputProtocol? { get set }
}
