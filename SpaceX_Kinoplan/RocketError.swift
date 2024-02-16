//
//  RocketError.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 25.01.2024.
//

import Foundation
import Alamofire

enum RocketError {
  case badURL
  case invalidData
  case decodingError
  case requestError(AFError)
  
  init(error: AFError) {
    switch error {
    case .invalidURL(_):
      self = .badURL
    case .responseValidationFailed(_):
      self = .invalidData
    case .responseSerializationFailed(_):
      self = .decodingError
    default:
      self = .requestError(error)
    }
  }
}
extension RocketError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .badURL:
      NSLocalizedString("Не подходящий url адрес", comment: "")
    case .invalidData:
      NSLocalizedString("Не вышло создать data", comment: "")
    case .decodingError:
      NSLocalizedString("Не получилось декодировать данные", comment: "")
    case .requestError(let error):
      error.localizedDescription
    }
  }
}
