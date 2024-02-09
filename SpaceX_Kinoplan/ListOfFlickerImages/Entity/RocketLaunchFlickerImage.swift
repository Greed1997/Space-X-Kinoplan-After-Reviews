//
//  RocketLaunchFlickerImage.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import Foundation

// MARK: - RocketLaunchFlickerImage
struct RocketLaunchFlickerImage: Decodable, Hashable {
  
  // MARK: - Properties
  let missionName: String?
  let links: RocketLaunchLinks?
  
  // MARK: - CodingKeys
  enum CodingKeys: String, CodingKey {
    case missionName = "mission_name"
    case links = "links"
  }
}
// MARK: - RocketLaunchFlickerImagesLinks
struct RocketLaunchFlickerImagesLinks: Decodable, Hashable {
  
  // MARK: - Properties
  let flickrImages: String?
  
  // MARK: - CodingKeys
  enum CodingKeys: String, CodingKey {
    case flickrImages = "flickr_images"
  }
}
