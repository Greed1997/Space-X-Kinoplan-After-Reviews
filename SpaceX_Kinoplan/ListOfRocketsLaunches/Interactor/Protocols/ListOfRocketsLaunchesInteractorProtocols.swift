//
//  ListOfRocketsLaunchesInteractorInputProtocol.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import Foundation

// MARK: - ListOfRocketsLaunchesInteractorInputProtocol

protocol ListOfRocketsLaunchesInteractorInputProtocol: AnyObject {
  func obtainRocketsLaunches()
}

// MARK: - ListOfRocketsLaunchesInteractorOutputProtocol

protocol ListOfRocketsLaunchesInteractorOutputProtocol: AnyObject {
  func dataFetched(rocketLaunches: [RocketLaunch])
}
