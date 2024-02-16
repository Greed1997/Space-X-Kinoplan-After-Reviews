//
//  ListOfFlickerImagesViewControllerProtocols.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import ViperMcFlurry

// MARK: - ListOfFlickerImagesViewInputProtocol

protocol ListOfFlickerImagesViewInputProtocol: AnyObject {
  func setData(viewModel: ViewModel)
}

// MARK: - ListOfFlickerImagesViewOutputProtocol

protocol ListOfFlickerImagesViewOutputProtocol: AnyObject, RamblerViperModuleInput {
  func viewDidLoad()
  func setVariable(for rocketLaunch: RocketLaunch)
  func dismiss()
}

// MARK: - ListOfFlickerImagesViewProtocol

protocol ListOfFlickerImagesViewProtocol: AnyObject, ListOfFlickerImagesViewInputProtocol, RamblerViperModuleTransitionHandlerProtocol {
  var output: ListOfFlickerImagesViewOutputProtocol? { get set }
}
