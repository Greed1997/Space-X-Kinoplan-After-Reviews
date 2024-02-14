//
//  RocketLaunchInfoPresenter.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 26.01.2024.
//

import UIKit

// MARK: - RocketLaunchInfoPresenter

final class RocketLaunchInfoPresenter: NSObject, RocketLaunchInfoOutputProtocol {
  
  // MARK: - Connections
  
  var router: RocketLaunchInfoRouterProtocol!
  weak var view: RocketLaunchInfoViewInputProtocol?
  
  // MARK: - Properties
  
  var rocketLaunch: RocketLaunch!
  
  // MARK: - Init
  
  required init(
    router: RocketLaunchInfoRouterProtocol,
    view: RocketLaunchInfoViewInputProtocol
  ) {
    self.router = router
    self.view = view
  }
  
  //MARK: - View did load
  
  func viewDidLoad() {
    convert(rocketLaunch: rocketLaunch)
  }
  
  
  // MARK: - Go to the list of flicker images view controller
  
  func flickerImagesButtonTapped() {
    if let rocketLaunch {
      router.showFlickerImagesVC(rocketLaunch: rocketLaunch)
    }
  }
  
  // MARK: - Go to the list of rocket launches view controller
  
  func popToRoot() {
    router.popToRoot()
  }
}

// MARK: - Set started rocket launch to vc

extension RocketLaunchInfoPresenter {
  func setVariable(for rocketLaunch: RocketLaunch) {
    self.rocketLaunch = rocketLaunch
  }
}

// MARK: - Convert rocket launch to rocket launch info view model

private extension RocketLaunchInfoPresenter {

  func convert(rocketLaunch: RocketLaunch) {
    
    let rocketLaunchInfoViewModel = RocketLaunchInfoViewModel( // где я должен держать структуру x.RocketLaunchInfoViewModel; x - ?
      missionName: "Mission name: " + "\(rocketLaunch.missionName!)",
      missionPatchImageViewURL: URL(string: rocketLaunch.links?.missionPatch ?? "https://www.eso.org/public/archives/images/screen/eso1124d.jpg"),
      missionDate: "Date: " + "\(rocketLaunch.launchDateLocal!)",
      youtubeLink: rocketLaunch.links?.youtubeId,
      wikiLink: rocketLaunch.links?.wikipedia,
      redditLink: rocketLaunch.links?.redditLaunch,
      articleLink: rocketLaunch.links?.articleLink, 
      flickerImagesURLsStrings: rocketLaunch.links?.flickrImages)
    
    view?.viewDidLoadFromOutput(rocketLaunchInfoViewModel: rocketLaunchInfoViewModel)
  }
}

//MARK: - Links functions

extension RocketLaunchInfoPresenter {
  
  func youtubeButtonTapped() {
    if let videoID = rocketLaunch.links?.youtubeId {
      if let url = URL(string: "youtube://www.youtube.com/watch?v=\(videoID)") {
        if UIApplication.shared.canOpenURL(url) {
          UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
          if let webURL = URL(string: "https://www.youtube.com/watch?v=\(videoID)") {
            UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
          }
        }
      }
    }
  }
  
  func wikiButtonTapped() {
    if let wikiLink = rocketLaunch?.links?.wikipedia {
      if let url = URL(string: wikiLink) {
        UIApplication.shared.open(url)
      }
    }
  }
  
  func redditButtonTapped() {
    if let redditLink = rocketLaunch?.links?.redditLaunch {
      if let url = URL(string: redditLink) {
        UIApplication.shared.open(url)
      }
    }
  }
  
  func articleButtonTapped() {
    if let articleLink = rocketLaunch?.links?.articleLink {
      if let url = URL(string: articleLink) {
        UIApplication.shared.open(url)
      }
    }
  }
}
