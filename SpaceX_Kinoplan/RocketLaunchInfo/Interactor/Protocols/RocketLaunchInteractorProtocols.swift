//
//  RocketLaunchInteractorProtocols.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import Foundation

// MARK: - RocketLaunchInteractorInputProtocol
protocol RocketLaunchInteractorInputProtocol: AnyObject {
  init(output: RocketLaunchInteractorOutputProtocol, networkService: NetworkServiceProtocol, cacheStorage: CacheStorageProtocol)
}

// MARK: - RocketLaunchInteractorOutputProtocol
protocol RocketLaunchInteractorOutputProtocol: AnyObject {
  
}
// MARK: - RocketLaunchInfoInteractor
final class RocketLaunchInfoInteractor: RocketLaunchInteractorInputProtocol {
  
  // MARK: - Properties
  let networkService: NetworkServiceProtocol!
  let cacheStorage: CacheStorageProtocol!
  
  // MARK: - Connections
  weak var output: RocketLaunchInteractorOutputProtocol?
  
  // MARK: - Init
  init(output: RocketLaunchInteractorOutputProtocol, networkService: NetworkServiceProtocol, cacheStorage: CacheStorageProtocol) {
    self.output = output
    self.networkService = networkService
    self.cacheStorage = cacheStorage
  }
  
  
}
