//
//  ListOfFlickerImagesViewControllerProtocols.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import ViperMcFlurry

// MARK: - ListOfFlickerImagesViewInputProtocol
protocol ListOfFlickerImagesViewInputProtocol: AnyObject {
  func reloadCollectionView(flickerImagesUrlString: [String])
  func setTitleVC(title: String)
}


// MARK: - ListOfFlickerImagesViewOutputProtocol
protocol ListOfFlickerImagesViewOutputProtocol: AnyObject {
  init(view: ListOfFlickerImagesViewInputProtocol, router: ListOfFlickerImagesRouterProtocol, rocketLaunchInfo: RocketLaunchInfo?)
  func viewDidLoad()
}

// MARK: - ListOfFlickerImagesViewProtocol
protocol ListOfFlickerImagesViewProtocol: AnyObject, ListOfFlickerImagesViewInputProtocol, RamblerViperModuleTransitionHandlerProtocol {
  var output: ListOfFlickerImagesViewOutputProtocol? { get set }
}
