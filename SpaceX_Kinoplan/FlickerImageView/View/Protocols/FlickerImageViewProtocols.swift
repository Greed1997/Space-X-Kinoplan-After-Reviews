//
//  FlickerImageViewProtocols.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 14.02.2024.
//

import ViperMcFlurry

// MARK: - FlickerImageViewInputProtocol

protocol FlickerImageViewInputProtocol: AnyObject {
  func viewDidLoadFromOutput(flickerImageURL: URL)
}

// MARK: - FlickerImageViewOutputProtocol

protocol FlickerImageViewOutputProtocol: AnyObject, RamblerViperModuleInput {
  func viewDidLoad()
  func setVariable(_ flickerImageURL: URL)
}

// MARK: - FlickerImageViewProtocol

protocol FlickerImageViewProtocol: AnyObject, FlickerImageViewInputProtocol, RamblerViperModuleTransitionHandlerProtocol {
  var output: FlickerImageViewOutputProtocol? { get set }
}
