//
//  ListOfFlickerImagesViewControllerProtocols.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import ViperMcFlurry

struct FlickerImageViewModel {
  let title: String
  var flickerImageViewModel: [FlickerImageCell.FlickerImageViewModel]
}

// MARK: - ListOfFlickerImagesViewInputProtocol

protocol ListOfFlickerImagesViewInputProtocol: AnyObject {
  func setData(viewModel: FlickerImageViewModel)
}

// MARK: - ListOfFlickerImagesViewOutputProtocol

protocol ListOfFlickerImagesViewOutputProtocol: AnyObject, RamblerViperModuleInput {
  func viewDidLoad()
  func setVariable(for rocketLaunch: RocketLaunch)
  func onBackButtonTapped()
}

// MARK: - ListOfFlickerImagesViewProtocol

protocol ListOfFlickerImagesViewProtocol: AnyObject, ListOfFlickerImagesViewInputProtocol, RamblerViperModuleTransitionHandlerProtocol {
  var output: ListOfFlickerImagesViewOutputProtocol? { get set }
}
