//
//  RocketLaunchInfo.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import Foundation
// MARK: - RocketLaunchInfo
struct RocketLaunchInfo: Decodable, Hashable {
  
  // MARK: - Properties
  let missionName: String?
  let links: RockeLaunchInfoLinks?
  let launchDateLocal: String?
  
  // MARK: - CodingKeys
  enum CodingKeys: String, CodingKey {
    case missionName = "mission_name"
    case links = "links"
    case launchDateLocal = "launch_date_local"
  }
}
// MARK: - RockeLaunchInfoLinks
struct RockeLaunchInfoLinks: Decodable, Hashable {
  
  // MARK: - Properties
  let missionPatch: String?
  let redditLaunch: String?
  let wikipedia: String?
  let videoLink: String?
  let youtubeId: String?
  let articleLink: String?
  
  // MARK: - CodingKeys
  enum CodingKeys: String, CodingKey {
    case missionPatch = "mission_patch"
    case redditLaunch = "reddit_launch"
    case wikipedia = "wikipedia"
    case videoLink = "video_link"
    case youtubeId = "youtube_id"
    case articleLink = "article_link"
  }
}
