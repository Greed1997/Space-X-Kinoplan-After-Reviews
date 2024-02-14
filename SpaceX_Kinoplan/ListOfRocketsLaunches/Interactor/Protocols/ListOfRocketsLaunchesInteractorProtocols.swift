//
//  ListOfRocketsLaunchesInteractorInputProtocol.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import Foundation

// MARK: - ListOfRocketsLaunchesInteractorInputProtocol

protocol ListOfRocketsLaunchesInteractorInputProtocol: AnyObject {
  init(networkService: NetworkServiceProtocol)
  func fetchData()
}

// MARK: - ListOfRocketsLaunchesInteractorOutputProtocol

protocol ListOfRocketsLaunchesInteractorOutputProtocol: AnyObject {
  func dataFetched(rocketLaunches: [RocketLaunch])
}
