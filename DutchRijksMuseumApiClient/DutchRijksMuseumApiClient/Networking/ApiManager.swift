//
//  ApiManager.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation

public protocol APIManagerProtocol {
  func performURLRequest(from router: APIRouter, completionHandler: @escaping (Data?, NSError?) -> Void)
}

public class APIManager: APIManagerProtocol {
  private let session: NetworkSession
  private let baseURL: String
  private let apiKey: String
  
  public init(baseURL: String, apiKey: String) {
    session = ServiceNetworkSession()
    self.baseURL = baseURL
    self.apiKey = apiKey
  }
  
  public func performURLRequest(from router: APIRouter, completionHandler: @escaping (Data?, NSError?) -> Void) {
    do {
      let urlRequest = try router.createUrlRequest(withBaseURL: baseURL, withApiKey: apiKey)
      //TODO: Handle the authenticated or anonymous request.
      performURLRequest(for: urlRequest) { data, error in
        completionHandler(data, error)
      }
    } catch {
      completionHandler(nil, NSError(domain: "com.appstore.rijksmuseum.APIManager", code: 3))
    }
  }
  
  
  private func performURLRequest(for request: URLRequest, completionHandler: @escaping (Data?, NSError?) -> Void) {
    session.doRequest(for: request) { data, error in
      completionHandler(data, error)
    }
  }
  
  //TODO : Create perform URL Request for authenticated, bearer or tokenized request.
}
