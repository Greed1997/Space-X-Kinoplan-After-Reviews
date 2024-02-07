//
//  NetworkService.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 25.01.2024.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func fetchData(from urlString: String, completion: @escaping ((Result<[RocketLaunch], RocketError>) -> Void))
    func fetchData(from urlString: String) async throws -> [RocketLaunch]
    func fetchImage(from url: URL, completion: @escaping(Data, HTTPURLResponse) -> Void)
}
final class NetworkService: NetworkServiceProtocol {
    func fetchImage(from url: URL, completion: @escaping(Data, HTTPURLResponse) -> Void) {
        AF.request(url).validate().responseData { response in
            switch response.result {
            case .success(let data):
                guard let response = response.response else {
                    return
                }
                DispatchQueue.main.async {
                    completion(data, response)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func fetchData(from urlString: String, completion: @escaping ((Result<[RocketLaunch], RocketError>) -> Void)) {
        guard let url = URL(string: urlString) else {
            return
        }
        AF.request(url).validate().responseDecodable(of: [RocketLaunch].self) { response in
            switch response.result {
            case .success(let rocketLaunches):
                completion(.success(rocketLaunches))
            case .failure(let error):
                let rocketError = RocketError(error: error)
                completion(.failure(rocketError))
            }
        }
    }
    func fetchData(from urlString: String) async throws -> [RocketLaunch] {
        guard let url = URL(string: urlString) else {
            throw RocketError.badURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let rocketLaunch = try JSONDecoder().decode([RocketLaunch].self, from: data)
            return rocketLaunch
        } catch {
            throw error
        }
    }
}
