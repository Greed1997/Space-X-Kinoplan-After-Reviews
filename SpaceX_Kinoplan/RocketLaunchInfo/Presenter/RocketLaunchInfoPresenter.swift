//
//  RocketLaunchInfoPresenter.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 26.01.2024.
//

import UIKit

final class RocketLaunchInfoPresenter: NSObject {
  
  // MARK: - Connections
  
  weak var view: RocketLaunchInfoViewInputProtocol?
  var router: RocketLaunchInfoRouterProtocol!
  
  // MARK: - Properties
  
  private var rocketLaunch: RocketLaunch!
  
  // MARK: - Init
  
  init(
    view: RocketLaunchInfoViewInputProtocol,
    router: RocketLaunchInfoRouterProtocol
  ) {
    self.view = view
    self.router = router
  }
  
}

// MARK: - Convert rocket launch to rocket launch info view model

private extension RocketLaunchInfoPresenter {
  
  func convert(rocketLaunch: RocketLaunch) {
    
    let rocketLaunchInfoViewModel = RocketLaunchInfoViewModel(
      missionName: "Mission name: " + "\(rocketLaunch.missionName!)",
      missionPatchImageViewURL: rocketLaunch.links?.missionPatch.flatMap{ URL(string: $0) },
      missionDate: "Date: " + "\(rocketLaunch.launchDateLocal)",
      youtubeLink: rocketLaunch.links?.youtubeId,
      wikiLink: rocketLaunch.links?.wikipedia,
      redditLink: rocketLaunch.links?.redditLaunch,
      articleLink: rocketLaunch.links?.articleLink,
      flickerImages: rocketLaunch.links?.flickrImages)
    
    view?.set(viewModel: rocketLaunchInfoViewModel)
  }
}

// MARK: - RocketLaunchInfoOutputProtocol

extension RocketLaunchInfoPresenter: RocketLaunchInfoOutputProtocol {
  
  func viewDidLoad() {
    convert(rocketLaunch: rocketLaunch)
  }
  
  func onYoutubeButtonTapped() {
    if  let youtubeLink = rocketLaunch?.links?.videoLink,
        let url = URL(string: youtubeLink) {
      UIApplication.shared.open(url)
    }
  }
  
  func onWikiButtonTapped() {
    if  let wikiLink = rocketLaunch?.links?.wikipedia,
        let url = URL(string: wikiLink) {
      UIApplication.shared.open(url)
    }
  }
  
  func onRedditButtonTapped() {
    if  let redditLink = rocketLaunch?.links?.redditLaunch,
        let url = URL(string: redditLink) {
      UIApplication.shared.open(url)
    }
  }
  
  func onArticleButtonTapped() {
    if  let articleLink = rocketLaunch?.links?.articleLink,
        let url = URL(string: articleLink) {
      UIApplication.shared.open(url)
    }
  }
  
  func onFlickerImagesButtonTapped() {
    if let rocketLaunch {
      router.showFlickerImages(rocketLaunch: rocketLaunch)
    }
  }
  
  func onBackButtonTapped() {
    router.dismiss()
  }
  
  func setVariable(_ rocketLaunch: RocketLaunch) {
    self.rocketLaunch = rocketLaunch
  }
  
}
