//
//  RocketLaunchInteractorProtocols.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import UIKit

// MARK: - RocketLaunchInteractorInputProtocol
protocol RocketLaunchInfoInteractorInputProtocol: AnyObject {
  init(output: RocketLaunchInfoInteractorOutputProtocol, networkService: NetworkServiceProtocol)
  func fetchNeededRocketLaunchInfo(for index: Int)
  
}

// MARK: - RocketLaunchInteractorOutputProtocol
protocol RocketLaunchInfoInteractorOutputProtocol: AnyObject {
  func dataFetched(rocketLaunchInfo: RocketLaunchInfo)
}
