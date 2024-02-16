//
//  RocketLaunch.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 25.01.2024.
//

import Foundation

struct RocketLaunch: Decodable {
  
  // MARK: - Properties
  
  let missionName: String?
  let links: RocketLaunchLinks?
  let launchDateLocal: String
  
  // MARK: - CodingKeys
  
  enum CodingKeys: String, CodingKey {
    case missionName = "mission_name"
    case links = "links"
    case launchDateLocal = "launch_date_local"
  }
  
}

struct RocketLaunchLinks: Decodable {
  
  // MARK: - Properties
  
  let missionPatch: String?
  let redditLaunch: String?
  let wikipedia: String?
  let videoLink: String?
  let youtubeId: String?
  let articleLink: String?
  let flickrImages: [String]?
  
  // MARK: - CodingKeys
  
  enum CodingKeys: String, CodingKey {
    case missionPatch = "mission_patch"
    case redditLaunch = "reddit_launch"
    case wikipedia = "wikipedia"
    case videoLink = "video_link"
    case youtubeId = "youtube_id"
    case articleLink = "article_link"
    case flickrImages = "flickr_images"
  }
  
}
