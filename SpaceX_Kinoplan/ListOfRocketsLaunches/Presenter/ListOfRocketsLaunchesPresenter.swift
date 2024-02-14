//
//  ListOfRocketsLaunchesPresenter.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 26.01.2024.
//

import Foundation

// MARK: - ListOfRocketsLaunchesPresenter

final class ListOfRocketsLaunchesPresenter: NSObject, ListOfRocketsLaunchesViewOutputProtocol {
  
  // MARK: - Connections
  
  weak private var view: ListOfRocketsLaunchesViewInputProtocol?
  private var interactor: ListOfRocketsLaunchesInteractorInputProtocol
  private var router: ListOfRocketsLaunchesRouterInputProtocol
  
  // MARK: - Init
  
  required init(
    view: ListOfRocketsLaunchesViewInputProtocol?,
    interactor: ListOfRocketsLaunchesInteractorInputProtocol,
    router: ListOfRocketsLaunchesRouterInputProtocol
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }
  
}

// MARK: - View Output Methods

extension ListOfRocketsLaunchesPresenter {
  
  func viewDidLoad() {
    interactor.fetchData()
  }

}

// MARK: - Interactor output methods

extension ListOfRocketsLaunchesPresenter: ListOfRocketsLaunchesInteractorOutputProtocol {
  
  func dataFetched(rocketLaunches: [RocketLaunch]) {
    let convertedRocketLaunches = convert(rocketLaunches: rocketLaunches)
    view?.reloadCollectionView(rocketLaunchCellModels: convertedRocketLaunches)
  }
  
}

// MARK: - Convert and routing converted rocket launch data

private extension ListOfRocketsLaunchesPresenter {
  
  func convert(rocketLaunches: [RocketLaunch]) -> [RocketLaunchCell.ViewModel] {
    
    var arrayOfRocketLaunchCellModel: [RocketLaunchCell.ViewModel] = []
    
    rocketLaunches.forEach { rocketLaunch in
      let dateString = rocketLaunch.launchDateLocal!
      let index = dateString.firstIndex(of: "T")!
      let date = dateString.prefix(upTo: index)
      let time = dateString.suffix(from: dateString.index(after: index))
      let formatedString = "\(date)\n\(time)"
      
      arrayOfRocketLaunchCellModel.append(
        RocketLaunchCell.ViewModel(
          missionName: rocketLaunch.missionName,
          missionPatchImageViewURL: URL(string: rocketLaunch.links?.missionPatch ?? ""),
          missionDate: formatedString,
          onTap: { [weak self] in
            guard let self = self else { return }
            self.router.showRocketLaunchInfo(with: rocketLaunch)
          })
        )
    }
    return arrayOfRocketLaunchCellModel
  }
}
