//
//  RocketLaunchInfoPresenter.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 26.01.2024.
//

import UIKit

// MARK: - RocketLaunchInfoPresenter
final class RocketLaunchInfoPresenter: RocketLaunchInfoOutputProtocol {
  func popToRoot() {
    router.popToRoot()
  }
  
  
  // MARK: - Properties
  var rocketLaunchInfo: RocketLaunchInfo?
  var cacheStorage: KingFisherImageCacheStorage?
  var networkService: NetworkServiceProtocol?
  var index: Int!
  let duffyDuck = "https://upload.wikimedia.org/wikipedia/ru/thumb/6/64/%D0%94%D0%B0%D1%84%D1%84%D0%B8_%D0%94%D0%B0%D0%BA.jpeg/247px-%D0%94%D0%B0%D1%84%D1%84%D0%B8_%D0%94%D0%B0%D0%BA.jpeg"

  // MARK: - Connections
  var router: RocketLaunchInfoRouterProtocol!
  weak var view: RocketLaunchInfoViewInputProtocol?
  var interactor: RocketLaunchInfoInteractorInputProtocol?
  
  // MARK: - Init
  required init(router: RocketLaunchInfoRouterProtocol, view: RocketLaunchInfoViewInputProtocol) {
    self.router = router
    self.view = view
  }
  
  //MARK: - View did load
  func viewDidLoad() {
    interactor?.fetchNeededRocketLaunchInfo(for: index)
  }
  
  //MARK: - Links functions
  func youtubeButtonTapped() {
    if let videoID = rocketLaunchInfo?.links?.youtubeId {
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
    print(777)
    if let wikiLink = rocketLaunchInfo?.links?.wikipedia {
      if let url = URL(string: wikiLink) {
        UIApplication.shared.open(url)
      }
    }
  }
  
  func redditButtonTapped() {
    if let redditLink = rocketLaunchInfo?.links?.redditLaunch {
      print(555)
      if let url = URL(string: redditLink) {
        UIApplication.shared.open(url)
      }
    }
  }
  
  func articleButtonTapped() {
    if let articleLink = rocketLaunchInfo?.links?.articleLink {
      if let url = URL(string: articleLink) {
        UIApplication.shared.open(url)
      }
    }
  }
  
  // MARK: - Go to flicker images VC
  func flickerImagesButtonTapped() {
    if let rocketLaunchInfo {
      router.showFlickerImagesVC(rocketLaunchInfo: rocketLaunchInfo)
    }
//    router.
//    router?.goToListOfFlickerImagesVC(rocketLaunch: rocketLaunch!)
  }
}
extension RocketLaunchInfoPresenter: RocketLaunchInfoInteractorOutputProtocol {
  func dataFetched(rocketLaunchInfo: RocketLaunchInfo) {
    self.rocketLaunchInfo = rocketLaunchInfo
    view?.viewDidLoadFromOutput(missionNameText: "Mission name: \(String(describing: rocketLaunchInfo.missionName!))",
                                missionPatchURL: URL(string: rocketLaunchInfo.links?.missionPatch ?? duffyDuck) ?? URL(string: duffyDuck)!,
                                dateText: "Date: \(String(describing: rocketLaunchInfo.launchDateLocal!))",
                                rocketLaunchInfo: rocketLaunchInfo)
  }
  
  
}
