//
//  ListOfRocketsLaunchesInteractor.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 26.01.2024.
//

import RxSwift

// MARK: - ListOfRocketsLaunchesInteractor

final class ListOfRocketsLaunchesInteractor: ListOfRocketsLaunchesInteractorInputProtocol {
  
  // MARK: - Connections
  
  weak var output: ListOfRocketsLaunchesInteractorOutputProtocol?
  
  // MARK: - Services
  
  private var networkService: NetworkServiceProtocol
  
  // MARK: - Tools
  
  let bag = DisposeBag()
  
  // MARK: - Init
  
  init(
    networkService: NetworkServiceProtocol
  ) {
    self.networkService = networkService
  }
  
  
  // MARK: - Interactor input protocol methods
  
  func fetchData() {
    networkService.fetchAllRocketLaunchesData(from: "https://api.spacexdata.com/v3/launches")
      .subscribe(onNext: { [weak self] rocketLaunches in
        
      guard let self = self else { return }
        
      self.output?.dataFetched(rocketLaunches: rocketLaunches)
    }) { error in
      
      if let rocketError = error as? RocketError {
        print(rocketError.localizedDescription)
      } else {
        print(error.localizedDescription)
      }
    }.disposed(by: bag)
    
  }
  
}
