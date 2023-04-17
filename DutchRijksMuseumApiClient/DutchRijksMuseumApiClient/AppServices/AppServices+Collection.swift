//
//  AppServices+Collection.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation

extension AppServices {
  
  public func collectionsArts(completionHandler: @escaping ([CollectionDataModel]?, NSError?) -> Void) {
    let route = CollectionRouting.collection
    apiManager.performURLRequest(from: route) { data, error in
      if error != nil {
        print("error collection arts")
      } else {
        guard let responseData = data else { return }
        
        do {
          let collection = try JSONDecoder().decode(CollectionResult.self, from: responseData)
          completionHandler(self.methodMapCollectionResult(collection: collection), nil)
        } catch {
          print("JSONSerialization error:", error)
        }
      }
    }
  }
  
  public func collectionPage(pageNumber: Int, completionHandler: @escaping ([CollectionDataModel]?, NSError?) -> Void) {
    let route = CollectionRouting.collectionPage(page: pageNumber)
    apiManager.performURLRequest(from: route) { data, error in
      if error != nil {
        print("error collection arts")
      } else {
        guard let responseData = data else { return }
        
        do {
          let collection = try JSONDecoder().decode(CollectionResult.self, from: responseData)
          completionHandler(self.methodMapCollectionResult(collection: collection), nil)
        } catch {
          print("JSONSerialization error:", error)
        }
      }
    }
  }
  
  public func lastUsedElements(completionHandler: @escaping ([CollectionDataModel]?, NSError?) -> Void) {
    
  }
  
  
  private func methodMapCollectionResult(collection: CollectionResult) -> [CollectionDataModel]{
    collection.artObjects?.map({ artObject in
      CollectionDataModel(title: artObject.title ?? "", image: artObject.webImage?.url ?? "", width: artObject.webImage?.width ?? 0, height: artObject.webImage?.height ?? 0, author: artObject.principalMaker ?? "")
    }) ?? []
  }
  
}
