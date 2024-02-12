//
//  RocketLaunchInteractor.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import UIKit

// MARK: - RocketLaunchInfoInteractor
final class RocketLaunchInfoInteractor: RocketLaunchInfoInteractorInputProtocol {
  
  // MARK: - Properties
  let networkService: NetworkServiceProtocol!
  
  // MARK: - Connections
  weak var output: RocketLaunchInfoInteractorOutputProtocol?
  
  // MARK: - Init
  init(output: RocketLaunchInfoInteractorOutputProtocol, networkService: NetworkServiceProtocol) {
    self.output = output
    self.networkService = networkService
  }
  
  // MARK: - Fetch needed rocket launch info
  func fetchNeededRocketLaunchInfo(for index: Int) {
    networkService.fetchData(from: "https://api.spacexdata.com/v3/launches/\(index)") { [weak self] (result: Result<RocketLaunchInfo, RocketError>) in
      switch result {
      case .success(let rocketLaunchInfo):
        self?.output?.dataFetched(rocketLaunchInfo: rocketLaunchInfo)
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
}
