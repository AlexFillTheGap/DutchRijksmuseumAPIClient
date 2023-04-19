//
//  AppServices+Collection.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation

extension AppServices {
  public func collectionsArts(completionHandler: @escaping (CollectionDataResponse?, NSError?) -> Void) {
    let route = CollectionRouting.collection
    apiManager.performURLRequest(from: route) { data, error in
      if error != nil {
        print("error collection arts")
      } else {
        guard let responseData = data else { return }
        
        do {
          let collection = try JSONDecoder().decode(CollectionResult.self, from: responseData)
          completionHandler(self.methodMapCollectionResult(collection: collection, pageNumber: 0), nil)
        } catch {
          print("JSONSerialization error:", error)
        }
      }
    }
  }
  
  public func collectionPage(
    pageNumber: Int,
    completionHandler: @escaping (CollectionDataResponse?, NSError?) -> Void
  ) {
    let route = CollectionRouting.collectionPage(page: pageNumber)
    apiManager.performURLRequest(from: route) { data, error in
      if error != nil {
        print("error collection arts")
      } else {
        guard let responseData = data else { return }
        
        do {
          let collection = try JSONDecoder().decode(CollectionResult.self, from: responseData)
          completionHandler(self.methodMapCollectionResult(collection: collection, pageNumber: pageNumber), nil)
        } catch {
          print("JSONSerialization error:", error)
        }
      }
    }
  }
  
  private func methodMapCollectionResult(collection: CollectionResult, pageNumber: Int) -> CollectionDataResponse {
    return CollectionDataResponse(
      collectionDataList: collection.artObjects?.map { artObject in
        CollectionResponseItem(
          artObjectId: artObject.objectNumber ?? "",
          title: artObject.title ?? "",
          image: artObject.headerImage?.url ?? "",
          width: artObject.headerImage?.width ?? 0,
          height: artObject.headerImage?.height ?? 0,
          author: artObject.principalMaker ?? ""
        )
      } ?? [], pageNumber: pageNumber)
  }
}
