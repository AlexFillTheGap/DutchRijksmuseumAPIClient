//
//  AppServices+Detail.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 18/4/23.
//

import Foundation

extension AppServices: AppServiceDetailProtocol {
  public func detailedArt(objectId: String, completionHandler: @escaping (DetailDataResponse?, NSError?) -> Void) {
    let route = DetailRouting.detail(artId: objectId)
    apiManager.performURLRequest(from: route) { data, error in
      if error != nil {
        completionHandler(nil, error)
      } else {
        guard let responseData = data else { return }
        
        do {
          let detailArt = try JSONDecoder().decode(DetailResult.self, from: responseData)
          guard let artObject = detailArt.artObject else {
            return
          }
          completionHandler(DetailDataResponse(artObject: artObject), nil)
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
}
