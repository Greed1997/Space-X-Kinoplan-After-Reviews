//
//  ListOfRocketsLaunchesInteractorInputProtocol.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import Foundation

// MARK: - ListOfRocketsLaunchesInteractorInputProtocol
protocol ListOfRocketsLaunchesInteractorInputProtocol: AnyObject {
//  init(networkService: NetworkServiceProtocol, cacheStorage: CacheStorageProtocol)
  func fetchData()
  func getNeededRocketLaunch(index: Int)
}

// MARK: - ListOfRocketsLaunchesInteractorOutputProtocol
protocol ListOfRocketsLaunchesInteractorOutputProtocol: AnyObject {
  func dataFetched(rocketLaunches: [RocketLaunch])
  func goToRocketLaunchVC(rocketLaunch: RocketLaunch)
}
