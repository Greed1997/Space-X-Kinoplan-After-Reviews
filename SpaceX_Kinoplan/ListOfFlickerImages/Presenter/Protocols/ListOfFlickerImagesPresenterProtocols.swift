//
//  ListOfFlickerImagesPresenterProtocols.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import Foundation

// MARK: - ListOfFlickerImagesPresenterProtocol
protocol ListOfFlickerImagesPresenterProtocol: AnyObject {
    init(view: ListOfFlickerImagesViewProtocol, /*router: RouterProtocol,*/ rocketLaunch: RocketLaunch)
    func viewDidLoad()
}
