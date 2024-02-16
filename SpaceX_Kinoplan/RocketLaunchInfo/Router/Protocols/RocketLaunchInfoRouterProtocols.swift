//
//  RocketLaunchInfoRouterProtocols.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import Foundation

protocol RocketLaunchInfoRouterProtocol: AnyObject {
  func showFlickerImages(rocketLaunch: RocketLaunch)
  func dismiss()
}
