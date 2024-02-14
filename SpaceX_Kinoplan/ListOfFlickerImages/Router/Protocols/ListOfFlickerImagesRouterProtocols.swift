//
//  ListOfFlickerImagesRouterProtocols.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import ViperMcFlurry

protocol ListOfFlickerImagesRouterProtocol: AnyObject {
  var transitionHandler: RamblerViperModuleTransitionHandlerProtocol? { get set }
  func goToRocketLaunchInfo()
  func goToViewControllerWithSelectedFlickerImage(flickerImageURL: URL)
}

