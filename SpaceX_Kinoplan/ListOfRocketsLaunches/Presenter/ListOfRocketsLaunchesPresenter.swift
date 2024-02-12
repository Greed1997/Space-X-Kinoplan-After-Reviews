//
//  ListOfRocketsLaunchesPresenter.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 26.01.2024.
//

import Foundation

// MARK: - ListOfRocketsLaunchesPresenter
final class ListOfRocketsLaunchesPresenter: ListOfRocketsLaunchesViewOutputProtocol {
  
  // MARK: - Connections
  
  weak private var view: ListOfRocketsLaunchesViewInputProtocol?
  private var interactor: ListOfRocketsLaunchesInteractorInputProtocol
  private var router: ListOfRocketsLaunchesRouterInputProtocol
  
  // MARK: - Init
  
  init(
    view: ListOfRocketsLaunchesViewInputProtocol?,
    interactor: ListOfRocketsLaunchesInteractorInputProtocol,
    router: ListOfRocketsLaunchesRouterInputProtocol
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }
  
  // MARK: - View Output Methods
  func viewDidLoad() {
    interactor.fetchData()
  }
  
  func getSelectedRocketLaunch(index: Int) {
    router.showRocketLaunchInfo(with: index)
  }
  
}
// MARK: - Interactor output methods
extension ListOfRocketsLaunchesPresenter: ListOfRocketsLaunchesInteractorOutputProtocol {
  
  func goToRocketLaunchVC(index: Int) {
    router.showRocketLaunchInfo(with: index)
  }
  
  func dataFetched(rocketLaunches: [RocketLaunch]) {
    var rocketLaunchCellModels: [RocketLaunchCellModel] = []
    rocketLaunches.forEach { rocketLaunch in
      let dateString = rocketLaunch.launchDateLocal!
      let index = rocketLaunch.launchDateLocal!.firstIndex(of: "T")!
      let date = dateString.prefix(upTo: index)
      let time = dateString.suffix(from: dateString.index(after: index))
      let formatedString = "\(date)\n\(time)"
      
      rocketLaunchCellModels.append(RocketLaunchCellModel(
        missionName: rocketLaunch.missionName,
        missionPatchImageViewURL: URL(string: rocketLaunch.links?.missionPatch ?? ""),
        missionDate: formatedString)
      )
    }
    view?.reloadCollectionView(rocketLaunchCellModels: rocketLaunchCellModels) // rocketLaunches = rocketLaunchCellModels
  }
  
}
