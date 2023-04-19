//
//  DetailInteractor.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation

protocol DetailInteractorProtocol {
  var appServices: AppServices { get set }
  func loadArtDetais(objectId: String)
}

class DetailInteractor: DetailInteractorProtocol {
  var appServices: AppServices
  var presenter: DetailPresenterProtocol?
  
  init(appServicesDependency: AppServices) {
    appServices = appServicesDependency
  }
  
  func loadArtDetais(objectId: String) {
    presenter?.makeShowLoading()
    appServices.detailedArt(objectId: objectId) { detailDataResponse, error in
      if error != nil {
        self.handleError(error: error)
      } else {
        guard let response = detailDataResponse else { return }
        self.presenter?.setupObjetData(response: response)
        self.presenter?.makeHideLoading()
      }
    }
  }
  
  private func handleError(error: NSError?) {
    let title = error?.userInfo[NSLocalizedDescriptionKey] as? String
    let message = error?.userInfo[NSLocalizedRecoverySuggestionErrorKey] as? String
    presenter?.showErrorAlert(
      title: title,
      message: message
    )
  }
}
