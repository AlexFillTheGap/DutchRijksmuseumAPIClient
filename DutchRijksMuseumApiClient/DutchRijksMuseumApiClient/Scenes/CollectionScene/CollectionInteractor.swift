//
//  CollectionInteractor.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation

protocol CollectionInteractorProtocol {
  var appServices: AppServices { get set }
  func selectArt(item: CollectionDataRequest)
  func loadArts()
  func nextPage()
  func previousPage()
  func firstPage()
}

class CollectionInteractor: CollectionInteractorProtocol {

  var appServices: AppServices
  var presenter: CollectionPresenterProtocol?
  var collectionItems: CollectionDataResponse?
  var visitedItems: [CollectionDataItem] = []
  var pageNumber: Int = 1
  
  init(appServicesDependency: AppServices) {
    self.appServices = appServicesDependency
  }
  
  func selectArt(item: CollectionDataRequest) {
    appServices.collectionRepository.addVisitedElement(item.selectedItem)
    let visited = self.getVisitedFromRepository()
  }
  
  func loadArts() {
    presenter?.makeShowLoading()
    appServices.collectionsArts { collection, error in
      if error != nil {
        print(error)
      } else {
        guard let collection = collection else { return }
        let visited = self.getVisitedFromRepository()
        self.presenter?.setupCollectionData(data: collection, visited: visited, pageNumber: self.pageNumber)
        self.presenter?.makeHideLoading()
      }
    }
  }
  
  private func getVisitedFromRepository() -> [CollectionDataItem] {
    let visited = self.appServices.collectionRepository.getVisited()
    switch visited {
    case .empty:
      return []
    case .loaded(let value):
      return value
    case .failed( _):
      return []
    }
  }
  
  func firstPage() {
    presenter?.makeShowLoading()
    appServices.collectionPage(pageNumber: pageNumber) { collectionDataResponse, error in
      if error != nil {
        print(error)
      } else {
        guard let collection = collectionDataResponse else { return }
        let visited = self.getVisitedFromRepository()
        self.presenter?.setupCollectionData(data: collection, visited: visited, pageNumber: self.pageNumber)
        self.presenter?.makeHideLoading()
      }
    }
  }
  
  
  func nextPage() {
    if pageNumber<1000 {
      presenter?.makeShowLoading()
      pageNumber += 1
      appServices.collectionPage(pageNumber: pageNumber, completionHandler: { collectionDataResponse, error in
        if error != nil {
          print(error)
        } else {
          guard let collection = collectionDataResponse else { return }
          let visited = self.getVisitedFromRepository()
          self.presenter?.setupCollectionData(data: collection, visited: visited, pageNumber: self.pageNumber)
          self.presenter?.makeHideLoading()
        }
      })
    }
  }
  
  func previousPage() {
    if pageNumber>1 {
      presenter?.makeShowLoading()
      pageNumber -= 1
      appServices.collectionPage(pageNumber: pageNumber, completionHandler: { collectionDataResponse, error in
        if error != nil {
          print(error)
        } else {
          guard let collection = collectionDataResponse else { return }
          let visited = self.getVisitedFromRepository()
          self.presenter?.setupCollectionData(data: collection, visited: visited, pageNumber: self.pageNumber)
          self.presenter?.makeHideLoading()
        }
      })
    }
  }
  
}
