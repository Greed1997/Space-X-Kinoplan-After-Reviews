//
//  ListOfFlickerImagesRouterProtocols.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 08.02.2024.
//

import Foundation

protocol ListOfFlickerImagesRouterProtocol: AnyObject {
  func dismiss()
  func presentViewControllerWithSelectedFlickerImage(flickerImageURL: URL)
}
