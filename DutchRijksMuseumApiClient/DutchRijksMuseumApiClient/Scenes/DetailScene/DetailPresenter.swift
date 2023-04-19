//
//  DetailPresenter.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation

protocol DetailPresenterProtocol {
  func setupObjetData(response: DetailDataResponse)
  func makeShowLoading()
  func makeHideLoading()
}

class DetailPresenter: DetailPresenterProtocol {
  var view: DetailViewControllerProtocol?
  
  func makeShowLoading() {
    view?.needToShowLoading()
  }
  
  func makeHideLoading() {
    view?.needToHideLoading()
  }
  
  func setupObjetData(response: DetailDataResponse) {
    view?.setupArtObject(
      artObjects: DetailDataModel(
        selectedItemID: response.artObject.id ?? "",
        imageUrl: response.artObject.webImage?.url ?? "",
        title: response.artObject.title ?? "",
        author: response.artObject.principalMakers?.first?.name ?? "",
        description: response.artObject.label?.description ?? ""
      )
    )
  }
}
