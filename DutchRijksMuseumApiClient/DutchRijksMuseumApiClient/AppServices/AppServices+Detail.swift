//
//  AppServices+Detail.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 18/4/23.
//

import Foundation

extension AppServices {
  public func detailedArt(objectId: String, completionHandler: @escaping (DetailDataResponse?, NSError?) -> Void) {
    let route = DetailRouting.detail(artId: objectId)
    apiManager.performURLRequest(from: route) { data, error in
      if error != nil {
        print("error collection arts")
      } else {
        guard let responseData = data else { return }
        
        do {
          let detailArt = try JSONDecoder().decode(DetailResult.self, from: responseData)
          guard let artObject = detailArt.artObject else { throw NSError() }
          completionHandler(DetailDataResponse(artObject: artObject), nil)
        } catch {
          print("JSONSerialization error:", error)
        }
      }
    }
  }
}
