//
//  NetworkService.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 25.01.2024.
//

import Foundation
import Alamofire
import RxSwift

// MARK: - NetworkServiceProtocol

protocol NetworkServiceProtocol {
  func fetchAllRocketLaunchesData() -> Observable<[RocketLaunch]>
}

// MARK: - NetworkService

final class NetworkService: NetworkServiceProtocol {
  
  func fetchAllRocketLaunchesData() -> Observable<[RocketLaunch]> {
    guard let url = URL(string: "https://api.spacexdata.com/v3/launches") else {
      return .error(RocketError.badURL)
    }
    return Observable<[RocketLaunch]>.create { observer in
      let request = AF.request(url).validate().responseDecodable(of: [RocketLaunch].self) { response in
        switch response.result {
        case .success(let rocketLaunches):
          observer.onNext(rocketLaunches)
          observer.onCompleted()
        case .failure(let error):
          observer.onError(error)
        }
      }
      return Disposables.create {
        request.cancel()
      }
    }
  }
  
}
