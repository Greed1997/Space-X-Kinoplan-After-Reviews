//
//  CacheStorage.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 28.01.2024.
//

import UIKit
import Kingfisher

// MARK: - KingFisherImageCacheStorageProtocol
protocol KingFisherImageCacheStorageProtocol: AnyObject {
  func getCachedImage(forKey urlString: String, completion: @escaping (UIImage?) -> Void)
  func saveImageToCache(image: UIImage?, with key: String)
}

// MARK: - KingFisherImageCacheStorage
final class KingFisherImageCacheStorage: KingFisherImageCacheStorageProtocol {
  
  // MARK: - Save to cache
  func saveImageToCache(image: UIImage?, with key: String) {
    getCachedImage(forKey: key) { image in
      if let image {
        let cache = ImageCache.default
        cache.memoryStorage.config.expiration = .days(1)
        cache.store(image, forKey: key)
      }
    }
  }
  
  // MARK: - Get from cache
  func getCachedImage(forKey urlString: String, completion: @escaping (UIImage?) -> Void) {
    guard let url = URL(string: urlString) else {
      completion(nil)
      return }
    let resource = KF.ImageResource(downloadURL: url)
    KingfisherManager.shared.retrieveImage(with: resource) { result in
      switch result {
      case .success(let value):
        completion(value.image)
      case .failure(_):
        completion(nil)
      }
    }
  }
}
