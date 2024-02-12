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
  func fetchData<T: Decodable>(from urlString: String, completion: @escaping ((Result<[T], RocketError>) -> Void))
  func fetchData<T: Decodable>(from urlString: String, completion: @escaping ((Result<T, RocketError>) -> Void))
  
  
}

// MARK: - NetworkService
final class NetworkService: NetworkServiceProtocol {
  func fetchData<T>(from urlString: String, completion: @escaping ((Result<T, RocketError>) -> Void)) where T : Decodable {
    guard let url = URL(string: urlString) else {
      return
    }
    AF.request(url).validate().responseDecodable(of: T.self) { response in
      switch response.result {
      case .success(let rocketLaunches):
        completion(.success(rocketLaunches))
      case .failure(let error):
        let rocketError = RocketError(error: error)
        completion(.failure(rocketError))
      }
    }
  }
  
  
  // MARK: - Fetch data
  func fetchData<T: Decodable>(from urlString: String, completion: @escaping ((Result<[T], RocketError>) -> Void)) {
    guard let url = URL(string: urlString) else {
      return
    }
    AF.request(url).validate().responseDecodable(of: [T].self) { response in
      switch response.result {
      case .success(let rocketLaunches):
        completion(.success(rocketLaunches))
      case .failure(let error):
        let rocketError = RocketError(error: error)
        completion(.failure(rocketError))
      }
    }
  }
}
