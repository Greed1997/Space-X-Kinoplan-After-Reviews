//
//  FlickerImageViewProtocols.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 14.02.2024.
//

import ViperMcFlurry

// MARK: - FlickerImageViewInputProtocol

protocol FlickerImageViewInputProtocol: AnyObject {
  func viewDidLoadFromOutput(flickerImageViewModel: FlickerImageViewModel)
}

// MARK: - FlickerImageViewOutputProtocol

protocol FlickerImageViewOutputProtocol: AnyObject, RamblerViperModuleInput {
  init(
    router: FlickerImageViewRouterProtocol,
    view: FlickerImageViewInputProtocol
  )
  func viewDidLoad()
  func setVariable(for flickerImageURL: URL)
}


// MARK: - FlickerImageViewProtocol

protocol FlickerImageViewProtocol: AnyObject, FlickerImageViewInputProtocol, RamblerViperModuleTransitionHandlerProtocol {
  var output: FlickerImageViewOutputProtocol? { get set }
}

// MARK: - FlickerImageViewModel

struct FlickerImageViewModel {
  
  let flickerImageURL: URL
}
