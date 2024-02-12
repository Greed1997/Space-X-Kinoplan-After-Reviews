//
//  ListOfRocketsLaunchesInteractor.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 26.01.2024.
//

import Foundation

// MARK: - ListOfRocketsLaunchesInteractor

final class ListOfRocketsLaunchesInteractor: ListOfRocketsLaunchesInteractorInputProtocol {
  
  // MARK: - Connections
  
  weak var output: ListOfRocketsLaunchesInteractorOutputProtocol?
  
  // MARK: - Services
  
  private var networkService: NetworkServiceProtocol
  private var cacheStorage  : KingFisherImageCacheStorage
  
  // MARK: - Properties
  
  var rocketLaunches: [RocketLaunch]? = []
  
  // MARK: -

  init(
    networkService: NetworkServiceProtocol,
    cacheStorage: KingFisherImageCacheStorage
  ) {
    self.networkService = networkService
    self.cacheStorage = cacheStorage
  }
  
  // MARK: - Init
//  required init(networkService: NetworkServiceProtocol, cacheStorage: CacheStorageProtocol) {
//    self.networkService = networkService
//    self.cacheStorage = cacheStorage
//  }
  
  
  // MARK: - Interactor input protocol methods
  // Fetch data for all rocket launches
  func fetchData() {
    networkService.fetchData(from: "https://api.spacexdata.com/v3/launches") { [weak self] (result: Result<[RocketLaunch], RocketError>) in
      guard let self = self else { return }
      switch result {
      case .success(let rocketLaunches):
        self.output?.dataFetched(rocketLaunches: rocketLaunches)
        self.rocketLaunches = rocketLaunches
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }

}
