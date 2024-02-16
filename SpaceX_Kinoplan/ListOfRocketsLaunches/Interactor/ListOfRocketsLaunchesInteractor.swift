//
//  ListOfRocketsLaunchesInteractor.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 26.01.2024.
//

import RxSwift

// MARK: - ListOfRocketsLaunchesInteractor

final class ListOfRocketsLaunchesInteractor {
  
  // MARK: - Connections
  
  weak var output: ListOfRocketsLaunchesInteractorOutputProtocol?
  
  // MARK: - Services
  
  private let networkService: NetworkServiceProtocol
  
  // MARK: - Tools
  
  let bag = DisposeBag()
  
  // MARK: - Init
  
  init(
    networkService: NetworkServiceProtocol
  ) {
    self.networkService = networkService
  }
  
}

// MARK: - ListOfRocketsLaunchesInteractorInputProtocol

extension ListOfRocketsLaunchesInteractor: ListOfRocketsLaunchesInteractorInputProtocol {
  
  func obtainRocketsLaunches() {
    networkService.fetchAllRocketLaunchesData()
      .subscribe(onNext: { [weak self] rocketLaunches in
        
        self?.output?.dataFetched(rocketLaunches: rocketLaunches)
      }) { error in
        
        if let rocketError = error as? RocketError {
          print(rocketError.localizedDescription)
        } else {
          print(error.localizedDescription)
        }
      }.disposed(by: bag)
  }
  
}
