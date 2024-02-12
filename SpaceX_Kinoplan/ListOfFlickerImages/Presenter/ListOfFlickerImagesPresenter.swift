//
//  ListOfFlickerImagesPresenter.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 26.01.2024.
//

import Foundation

// MARK: - ListOfFlickerImagesPresenter
final class ListOfFlickerImagesPresenter: ListOfFlickerImagesViewOutputProtocol {
  
  // MARK: - Properties
  let rocketLaunchInfo: RocketLaunchInfo?
  
  // MARK: - Connections
  var router: ListOfFlickerImagesRouterProtocol?
  weak var view: ListOfFlickerImagesViewInputProtocol?
  
  // MARK: - Init
  required init(view: ListOfFlickerImagesViewInputProtocol, router: ListOfFlickerImagesRouterProtocol, rocketLaunchInfo: RocketLaunchInfo?) {
    self.view = view
    self.rocketLaunchInfo = rocketLaunchInfo
    self.router = router
  }
  
  // MARK: - View did load
  func viewDidLoad() {
    guard let missionName = rocketLaunchInfo?.missionName else { return }
    guard let flickerImages = rocketLaunchInfo?.links?.flickrImages else { return }
    
    view?.setTitleVC(title: missionName)
    view?.reloadCollectionView(flickerImagesUrlString: flickerImages)
  }
  
  
}
