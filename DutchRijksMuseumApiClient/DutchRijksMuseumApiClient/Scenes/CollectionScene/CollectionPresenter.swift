//
//  CollectionPresenter.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation

protocol CollectionPresenterProtocol {
  func setupCollectionData(data: CollectionDataResponse, visited: [CollectionDataItem], pageNumber: Int)
  func makeShowLoading()
  func makeHideLoading()
}

class CollectionPresenter: CollectionPresenterProtocol {
  
  var view: CollectionViewControllerProtocol?
  
  func setupCollectionData(data: CollectionDataResponse, visited: [CollectionDataItem], pageNumber: Int) {
    let artObjects = CollectionDataModel(collectionDataList: data.collectionDataList.map { item in
      CollectionDataItem(
        artObjectId: item.artObjectId ,
        title: item.title,
        image: item.image,
        width: item.width,
        height: item.height,
        author: item.author
      )
    }, collectionVisitedList: visited, pageNumber: pageNumber)
    self.view?.setupArtObjects(artObjects: artObjects)
  }
  
  func makeShowLoading() {
    view?.needToShowLoading()
  }
  
  func makeHideLoading() {
    view?.needToHideLoading()
  }
}
