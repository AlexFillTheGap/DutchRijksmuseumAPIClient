//
//  CollectionPresenter.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation

protocol CollectionPresenterProtocol {
  func setupCollectionData(data: CollectionDataResponse, pageNumber: Int)
  func makeShowLoading()
  func makeHideLoading()
  func performDetailNavigation(detailItem: CollectionDataItem)
}

class CollectionPresenter: CollectionPresenterProtocol {
  var view: (CollectionViewControllerProtocol & CollectionViewControllerNavigation)?
  
  func setupCollectionData(data: CollectionDataResponse, pageNumber: Int) {
    let artObjects = CollectionDataModel(
      collectionDataList: data.collectionDataList.map { item in
        CollectionDataItem(
          artObjectId: item.artObjectId,
          title: item.title,
          image: item.image,
          width: item.width,
          height: item.height,
          author: item.author
        )
      }, pageNumber: pageNumber)
    self.view?.setupArtObjects(artObjects: artObjects)
  }
  
  func makeShowLoading() {
    view?.needToShowLoading()
  }
  
  func makeHideLoading() {
    view?.needToHideLoading()
  }
  
  func performDetailNavigation(detailItem: CollectionDataItem) {
    view?.goToDetail(item: detailItem)
  }
}
