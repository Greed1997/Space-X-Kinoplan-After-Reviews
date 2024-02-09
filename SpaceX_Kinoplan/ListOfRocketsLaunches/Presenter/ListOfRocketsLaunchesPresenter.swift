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
  weak var view: ListOfRocketsLaunchesViewInputProtocol?
  var interactor: ListOfRocketsLaunchesInteractorInputProtocol?
  var router: ListOfRocketsLaunchesRouterInputProtocol?
  
  // MARK: - View Output Methods
  func viewDidLoad() {
    interactor?.fetchData()
  }
  
  func getSelectedRocketLaunch(index: Int) {
    interactor?.getNeededRocketLaunch(index: index)
  }
  
}
// MARK: - Interactor output methods
extension ListOfRocketsLaunchesPresenter: ListOfRocketsLaunchesInteractorOutputProtocol {
  
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
  
  func goToRocketLaunchVC(rocketLaunch: RocketLaunch) {
    //        router?.goToRocketLaunchInfoVC(rocketLaunch: rocketLaunch)
    router?.showRocketLaunchInfo(with: rocketLaunch)
  }
}
