//
//  ListOfFlickerImagesViewControllerProtocols.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import ViperMcFlurry

// MARK: - ListOfFlickerImagesViewInputProtocol

protocol ListOfFlickerImagesViewInputProtocol: AnyObject {
  func reloadCollectionView(flickerImagesCellModels: [FlickerImageCell.ViewModel])
  func setTitleVC(title: String)
}


// MARK: - ListOfFlickerImagesViewOutputProtocol

protocol ListOfFlickerImagesViewOutputProtocol: AnyObject, RamblerViperModuleInput {
  init(
    view: ListOfFlickerImagesViewInputProtocol,
    router: ListOfFlickerImagesRouterProtocol
  )
  func viewDidLoad()
  func setVariable(for rocketLaunch: RocketLaunch)
  func showViewControllerWithSelectedFlickerImage(index: Int)
}

// MARK: - ListOfFlickerImagesViewProtocol

protocol ListOfFlickerImagesViewProtocol: AnyObject, ListOfFlickerImagesViewInputProtocol, RamblerViperModuleTransitionHandlerProtocol {
  var output: ListOfFlickerImagesViewOutputProtocol? { get set }
}
