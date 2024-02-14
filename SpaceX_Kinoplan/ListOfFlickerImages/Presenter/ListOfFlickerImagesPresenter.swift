//
//  ListOfFlickerImagesPresenter.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 26.01.2024.
//

import Foundation

// MARK: - ListOfFlickerImagesPresenter

final class ListOfFlickerImagesPresenter: NSObject, ListOfFlickerImagesViewOutputProtocol {
  
  
  // MARK: - Connections
  
  weak var view: ListOfFlickerImagesViewInputProtocol?
  var router: ListOfFlickerImagesRouterProtocol?
  
  // MARK: - Properties
  
  var rocketLaunch: RocketLaunch!
  
  // MARK: - Init
  
  required init(
    view: ListOfFlickerImagesViewInputProtocol,
    router: ListOfFlickerImagesRouterProtocol
  ) {
    self.view = view
    self.router = router
  }
  
  // MARK: - View did load
  
  func viewDidLoad() {
    let convertedFlickerImageViewModels = convert(rocketLaunch: rocketLaunch)
    view?.setTitleVC(title: rocketLaunch.missionName!)
    view?.reloadCollectionView(flickerImagesCellModels: convertedFlickerImageViewModels)
  }
  
}

// MARK: Convert rocket launch data to flicker images data

private extension ListOfFlickerImagesPresenter {
  
  func convert(rocketLaunch: RocketLaunch) -> [FlickerImageCell.ViewModel] {
    
    var arrayOfFlickerImageViewModel: [FlickerImageCell.ViewModel] = []
    
    rocketLaunch.links?.flickrImages?.forEach({ flickerImageString in
      guard let flickerImageURL = URL(string: flickerImageString) else { return }
      arrayOfFlickerImageViewModel.append(FlickerImageCell.ViewModel(flickerImageURL: URL(string: flickerImageString)!, onTap: { [weak self] in
        guard let self = self else { return }
        self.router?.goToViewControllerWithSelectedFlickerImage(flickerImageURL: flickerImageURL)
      }))
    })
    return arrayOfFlickerImageViewModel
  }
  
}

// MARK: - Set started rocket launch to vc

extension ListOfFlickerImagesPresenter {
  
  func setVariable(for rocketLaunch: RocketLaunch) {
    self.rocketLaunch = rocketLaunch
  }
}

// MARK: - Go to flicker image view controller

extension ListOfFlickerImagesPresenter {
  
  func showViewControllerWithSelectedFlickerImage(index: Int) {
    if let arrayOfFlickerImages = rocketLaunch.links?.flickrImages {
      if let flickerImageURL = URL(string: arrayOfFlickerImages[index]) {
        router?.goToViewControllerWithSelectedFlickerImage(flickerImageURL: flickerImageURL)
      }
    }
  }
}
