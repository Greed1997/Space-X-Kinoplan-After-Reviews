//
//  ListOfRocketsLaunchesInteractorInputProtocol.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import Foundation

protocol ListOfRocketsLaunchesInteractorInputProtocol: AnyObject {
    init(presenter: ListOfRocketsLaunchesInteractorOutputProtocol, networkService: NetworkServiceProtocol)
    func fetchData()
    func getNeededRocketLaunchInfo(index: Int)
}
