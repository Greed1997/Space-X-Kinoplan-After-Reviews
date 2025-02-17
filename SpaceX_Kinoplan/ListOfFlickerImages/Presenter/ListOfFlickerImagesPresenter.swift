//
//  ListOfFlickerImagesPresenter.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 26.01.2024.
//

import Foundation

final class ListOfFlickerImagesPresenter: NSObject {
  
  // MARK: - Connections
  
  private weak var view: ListOfFlickerImagesViewInputProtocol?
  private var router: ListOfFlickerImagesRouterProtocol?
  
  // MARK: - Properties
  
  private var rocketLaunch: RocketLaunch?
  
  // MARK: - Init
  
  init(
    view: ListOfFlickerImagesViewInputProtocol,
    router: ListOfFlickerImagesRouterProtocol
  ) {
    self.view = view
    self.router = router
  }
  
}

// MARK: - ListOfFlickerImagesViewOutputProtocol

extension ListOfFlickerImagesPresenter: ListOfFlickerImagesViewOutputProtocol {
  
  func onBackButtonTapped() {
    router?.dismiss()
  }
  
  func viewDidLoad() {
    view?.setData(
      viewModel: FlickerImageViewModel(
        title: rocketLaunch?.missionName ?? "",
        flickerImageViewModel: convert(rocketLaunch)
      )
    )
  }
  
  func setVariable(for rocketLaunch: RocketLaunch) {
    self.rocketLaunch = rocketLaunch
  }
  
}

// MARK: Convert rocket launch data to flicker images data

private extension ListOfFlickerImagesPresenter {
  
  func convert(_ rocketLaunch: RocketLaunch?) -> [FlickerImageCell.FlickerImageViewModel] {
    
    guard let flickerImages = rocketLaunch?.links?.flickrImages else { return [] }
    
    return flickerImages.compactMap({ flickerImageString in
      guard let flickerImageURL = URL(string: flickerImageString) else { return nil }
      return FlickerImageCell.FlickerImageViewModel(imageURL: flickerImageURL) { [weak self] in
        guard let self = self else { return }
        self.router?.presentFlickerImageModule(flickerImageURL: flickerImageURL)
      }
    })
    
  }
  
}

