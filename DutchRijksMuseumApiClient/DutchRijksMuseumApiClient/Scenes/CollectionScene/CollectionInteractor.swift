//
//  CollectionInteractor.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation

protocol CollectionInteractorProtocol {
  var appServices: AppServiceCollectionProtocol { get set }
  func selectArt(item: CollectionDataRequest)
  func nextPage()
  func firstPage()
}

class CollectionInteractor: CollectionInteractorProtocol {
  var appServices: AppServiceCollectionProtocol
  var presenter: CollectionPresenterProtocol?
  var collectionItems: CollectionDataResponse?
  var pageNumber: Int = 1
  
  init(appServicesDependency: AppServiceCollectionProtocol) {
    self.appServices = appServicesDependency
  }
  
  func selectArt(item: CollectionDataRequest) {
    self.presenter?.performDetailNavigation(detailItem: item.selectedItem)
  }
  
  private func handelError(error: NSError?) {
    let title = error?.userInfo[NSLocalizedDescriptionKey] as? String
    let message = error?.userInfo[NSLocalizedRecoverySuggestionErrorKey] as? String
    self.presenter?.showErrorAlert(
      title: title,
      message: message
    )
  }
  
  func firstPage() {
    presenter?.makeShowLoading()
    appServices.collectionPage(pageNumber: pageNumber) { collectionDataResponse, error in
      if error != nil {
        self.handelError(error: error)
      } else {
        guard let collection = collectionDataResponse else { return }
        self.presenter?.setupCollectionData(data: collection, pageNumber: self.pageNumber)
        self.presenter?.makeHideLoading()
      }
    }
  }
  
  func nextPage() {
    if pageNumber < 1000 {
      presenter?.makeShowLoading()
      pageNumber += 1
      appServices.collectionPage(pageNumber: pageNumber) { collectionDataResponse, error in
        if error != nil {
          self.handelError(error: error)
        } else {
          guard let collection = collectionDataResponse else { return }
          self.presenter?.setupCollectionData(data: collection, pageNumber: self.pageNumber)
          self.presenter?.makeHideLoading()
        }
      }
    }
  }
}
