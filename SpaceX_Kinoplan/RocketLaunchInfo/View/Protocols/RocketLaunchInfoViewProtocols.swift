//
//  RocketLaunchInfoViewProtocol.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import UIKit

// MARK: - RocketLaunchInfoViewProtocol
protocol RocketLaunchInfoViewProtocol: AnyObject {
    func viewDidLoadFromPresenter(rocketLaunch: RocketLaunch, missionNameText: String, dateText: String, image: UIImage?)
    func updateButtonAvailability(for rocketLaunch: RocketLaunch)
}
