//
//  ListOfRocketsLaunchesPresenter.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 26.01.2024.
//

import Foundation

final class ListOfRocketsLaunchesPresenter: NSObject {
  
  // MARK: - Connections
  
  weak private var view: ListOfRocketsLaunchesViewInputProtocol?
  private var interactor: ListOfRocketsLaunchesInteractorInputProtocol
  private var router: ListOfRocketsLaunchesRouterProtocol
  
  // MARK: - Init
  
  init(
    view: ListOfRocketsLaunchesViewInputProtocol?,
    interactor: ListOfRocketsLaunchesInteractorInputProtocol,
    router: ListOfRocketsLaunchesRouterProtocol
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }
  
}

// MARK: - ListOfRocketsLaunchesViewOutputProtocol

extension ListOfRocketsLaunchesPresenter: ListOfRocketsLaunchesViewOutputProtocol {
  
  func viewDidLoad() {
    interactor.obtainRocketsLaunches()
  }
  
}

// MARK: - ListOfRocketsLaunchesInteractorOutputProtocol

extension ListOfRocketsLaunchesPresenter: ListOfRocketsLaunchesInteractorOutputProtocol {
  
  func dataFetched(rocketLaunches: [RocketLaunch]) {
    let convertedRocketLaunches = convert(rocketLaunches: rocketLaunches)
    view?.reloadCollectionView(rocketLaunchCellModels: convertedRocketLaunches)
  }
  
}

// MARK: - Convert and routing converted rocket launch data

private extension ListOfRocketsLaunchesPresenter {
  
  func convert(rocketLaunches: [RocketLaunch]) -> [RocketLaunchCell.ViewModel] {
    return rocketLaunches.map { rocketLaunch in
      return RocketLaunchCell.ViewModel(
        missionName                  : rocketLaunch.missionName,
        missionPatchImageViewURL     : URL(string: rocketLaunch.links?.missionPatch ?? ""),
        missionDate                  : convertDate(date: rocketLaunch.launchDateLocal) ?? rocketLaunch.launchDateLocal,
        onTap                        : { [weak self] in
          self?.router.showRocketLaunchInfo(with: rocketLaunch)
        })}
    }
  
  func convertDate(date: String) -> String? {
    guard let index = date.firstIndex(of: "T") else { return date }
    let dateString        = date.prefix(upTo: index)
    let timeString        = date.suffix(from: date.index(after: index))
    return "\(dateString)\n\(timeString)"
  }
  
}
