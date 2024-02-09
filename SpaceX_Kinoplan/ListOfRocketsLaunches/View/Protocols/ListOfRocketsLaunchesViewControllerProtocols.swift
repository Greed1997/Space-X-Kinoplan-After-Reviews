//
//  ListOfRocketsLaunchesViewControllerInputProtocol.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import Foundation

// MARK: - ListOfRocketsLaunchesViewControllerInputProtocol
protocol ListOfRocketsLaunchesViewControllerInputProtocol: AnyObject {
    func reloadCollectionView(rocketLaunchCellModels: [RocketLaunchCellModel])
}
