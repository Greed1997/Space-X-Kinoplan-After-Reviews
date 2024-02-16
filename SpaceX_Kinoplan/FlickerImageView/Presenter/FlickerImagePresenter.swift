//
//  FlickerImagePresenter.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 14.02.2024.
//

import Foundation

final class FlickerImagePresenter: NSObject, FlickerImageViewOutputProtocol {
  
  // MARK: - Connections
  
  var router: FlickerImageViewRouterProtocol!
  weak var view: FlickerImageViewInputProtocol?
  
  // MARK: - Properties
  
  var flickerImageURL: URL!
  
  // MARK: - Init
  
  init(
    router: FlickerImageViewRouterProtocol,
    view: FlickerImageViewInputProtocol
  ) {
    self.router = router
    self.view = view
  }
  
  // MARK: - View did load
  
  func viewDidLoad() {
    view?.viewDidLoadFromOutput(flickerImageViewModel: FlickerImageViewModel(flickerImageURL: flickerImageURL))
  }
  
 
}

// MARK: - Resizing image

extension FlickerImagePresenter {
  func startResizingImage() {
    
  }
  
  
  // MARK: - Set current rocketLaunch
  
  func setVariable(for flickerImageURL: URL) {
    self.flickerImageURL = flickerImageURL
  }
}
