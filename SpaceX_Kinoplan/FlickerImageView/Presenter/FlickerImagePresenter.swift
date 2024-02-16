//
//  FlickerImagePresenter.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 14.02.2024.
//

import Foundation

final class FlickerImagePresenter: NSObject {
  
  // MARK: - Connections
  
  weak var view: FlickerImageViewInputProtocol?
  var router: FlickerImageRouterProtocol!
  
  // MARK: - Properties
  
  private var flickerImageURL: URL?
  
  // MARK: - Init
  
  init(
    view: FlickerImageViewInputProtocol,
    router: FlickerImageRouterProtocol
  ) {
    self.view = view
    self.router = router
  }
  
}

// MARK: - FlickerImageViewOutputProtocol

extension FlickerImagePresenter: FlickerImageViewOutputProtocol {
  
  // MARK: - View did load
  
  func viewDidLoad() {
    view?.viewDidLoadFromOutput(flickerImageURL: flickerImageURL!)
  }
  
  // MARK: - Set current rocketLaunch
  
  func setVariable(_ flickerImageURL: URL) {
    self.flickerImageURL = flickerImageURL
  }
  
}
