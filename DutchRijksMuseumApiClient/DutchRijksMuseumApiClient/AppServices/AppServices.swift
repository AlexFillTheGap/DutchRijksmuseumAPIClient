//
//  AppServices.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation

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
