//
//  RocketLaunch.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 25.01.2024.
//

import Foundation

// MARK: - RocketLaunch
struct RocketLaunch: Decodable, Hashable {
  
  // MARK: - Properties
  let missionName: String?
  let links: RocketLaunchLinks?
  let launchDateLocal: String?
  
  // MARK: - CodingKeys
  enum CodingKeys: String, CodingKey {
    case missionName = "mission_name"
    case links = "links"
    case launchDateLocal = "launch_date_local"
  }
}
// MARK: - RocketLaunchLinks
struct RocketLaunchLinks: Decodable, Hashable {
  
  // MARK: - Properties
  let missionPatch: String?
  
  // MARK: - CodingKeys
  enum CodingKeys: String, CodingKey {
    case missionPatch = "mission_patch"
  }
}
