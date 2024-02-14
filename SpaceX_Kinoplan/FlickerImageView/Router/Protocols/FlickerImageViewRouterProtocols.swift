//
//  FlickerImageViewRouterProtocols.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 14.02.2024.
//

import ViperMcFlurry

protocol FlickerImageViewRouterProtocol: AnyObject {
  var transitionHandler: RamblerViperModuleTransitionHandlerProtocol? { get set }
  func goToListOfFlickerImages()
}
