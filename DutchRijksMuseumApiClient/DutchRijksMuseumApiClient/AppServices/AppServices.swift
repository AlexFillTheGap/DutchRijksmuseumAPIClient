//
//  AppServices.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation

protocol AppServiceDetailProtocol {
  func detailedArt(objectId: String, completionHandler: @escaping (DetailDataResponse?, NSError?) -> Void)
}

protocol AppServiceCollectionProtocol {
  func collectionPage(
    pageNumber: Int,
    completionHandler: @escaping (CollectionDataResponse?, NSError?) -> Void
  )
}

public class AppServices {
  let apiManager: APIManagerProtocol
  
  init() {
    let apiManager = APIManager(baseURL: "https://www.rijksmuseum.nl/api/en", apiKey: "0fiuZFh4")
    self.apiManager = apiManager
  }
  
  init(
    apiManager: APIManagerProtocol
  ) {
    self.apiManager = apiManager
  }
}
