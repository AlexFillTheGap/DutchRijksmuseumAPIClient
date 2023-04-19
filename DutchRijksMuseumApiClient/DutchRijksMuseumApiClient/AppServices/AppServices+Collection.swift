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
        completionHandler(nil, error)
      } else {
        guard let responseData = data else { return }
        
        do {
          let collection = try JSONDecoder().decode(CollectionResult.self, from: responseData)
          completionHandler(self.methodMapCollectionResult(collection: collection, pageNumber: 0), nil)
        } catch {
          let serializationError = NSError(
            domain: "com.appstore.rijksmuseum.ServiceNetworkSession",
            code: 0,
            userInfo: [
              NSLocalizedDescriptionKey: "response_serialization_title".localized,
              NSLocalizedRecoverySuggestionErrorKey: "response_serialization_message".localized
            ]
          )
          completionHandler(nil, serializationError)
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
        completionHandler(nil, error)
      } else {
        guard let responseData = data else { return }
        
        do {
          let collection = try JSONDecoder().decode(CollectionResult.self, from: responseData)
          completionHandler(self.methodMapCollectionResult(collection: collection, pageNumber: pageNumber), nil)
        } catch {
          let serializationError = NSError(
            domain: "com.appstore.rijksmuseum.ServiceNetworkSession",
            code: 0,
            userInfo: [
              NSLocalizedDescriptionKey: "response_serialization_title".localized,
              NSLocalizedRecoverySuggestionErrorKey: "response_serialization_message".localized
            ]
          )
          completionHandler(nil, serializationError)
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
