//
//  AppServices.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation

public class AppServices {
  let apiManager: APIManagerProtocol
  let collectionRepository: CollectionRepositoryProtocol
  
  init() {
    let apiManager = APIManager(baseURL: "https://www.rijksmuseum.nl/api/en", apiKey: "0fiuZFh4")
    self.apiManager = apiManager
    collectionRepository = CollectionRepository()
  }
  
  init(
    apiManager: APIManagerProtocol,
    collectionRepository: CollectionRepository
  ) {
    self.apiManager = apiManager
    self.collectionRepository = collectionRepository
  }
  
}

