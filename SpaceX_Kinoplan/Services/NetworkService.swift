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
  func fetchOneRocketLaunchData(from urlString: String) -> Observable<RocketLaunch>
  func fetchAllRocketLaunchesData(from urlString: String) -> Observable<[RocketLaunch]>
}

// MARK: - NetworkService
final class NetworkService: NetworkServiceProtocol {
  
  func fetchOneRocketLaunchData(from urlString: String) -> Observable<RocketLaunch> {
    return Observable<RocketLaunch>.create { observer in
      guard let url = URL(string: urlString) else {
        let rocketError = RocketError.badURL
        observer.onError(rocketError)
        return Disposables.create()
      }
      let request = AF.request(url).validate().responseDecodable(of: RocketLaunch.self) { response in
        switch response.result {
        case .success(let data):
          observer.onNext(data)
          observer.onCompleted()
        case .failure(_):
          let rocketError = RocketError.decodingError
          observer.onError(rocketError)
        }
      }
      return Disposables.create {
        request.cancel()
      }
    }
  }
  func fetchAllRocketLaunchesData(from urlString: String) -> Observable<[RocketLaunch]> {
      return Observable<[RocketLaunch]>.create { observer in
        guard let url = URL(string: urlString) else {
          let rocketError = RocketError.badURL
          observer.onError(rocketError)
          return Disposables.create()
        }
        let request = AF.request(url).validate().responseDecodable(of: [RocketLaunch].self) { response in
          switch response.result {
          case .success(let rocketLaunches):
            observer.onNext(rocketLaunches)
            observer.onCompleted()
          case .failure(let error):
            let rocketError = RocketError.decodingError
            observer.onError(rocketError)
          }
        }
        return Disposables.create {
          request.cancel()
        }
      }
    }
}
