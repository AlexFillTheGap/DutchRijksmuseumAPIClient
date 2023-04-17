//
//  ApiRouter.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation

public enum APIHTTPMethod: String {
  case GET
  case POST
  case PUT
  case PATCH
  case DELETE
}

public protocol APIRouter {
  var path: String { get }
  var contentType: String { get }
  var body: Data? { get }
  var queryParameters: [String: Any]? { get }
  var httpMethod: APIHTTPMethod { get }
  var userAuthentication: Bool { get }
  var attemptsToTry: Int { get }
  var requestHeaders: [String: Any]? { get }
  var cachePolicy: URLRequest.CachePolicy { get }
  var errorDomain: String { get }
}

public extension APIRouter {
  var attemptsToTry: Int {
    2
  }
  
  var contentType: String {
    "application/json"
  }
  
  var body: Data? {
    nil
  }
  
  var queryParameters: [String: Any]? {
    nil
  }
  
  var requestHeaders: [String: Any]? {
    nil
  }
  
  var cachePolicy: URLRequest.CachePolicy {
    .reloadIgnoringLocalCacheData
  }
  
  var errorDomain: String {
    "com.appstore.alexerror.ApiRouter"
  }
  
  func createUrlRequest(withBaseURL baseURL: String, withApiKey apiKey: String) throws -> URLRequest {
    let error = NSError(
      domain: errorDomain,
      code: 0,
      userInfo: [
        NSLocalizedDescriptionKey: "request_build_title".localized,
        NSLocalizedRecoverySuggestionErrorKey: "request_build_message".localized
      ]
    )
    guard var components = URLComponents(string: baseURL + path) else {
      throw error
    }
    
    if let queryParameters = queryParameters, !queryParameters.isEmpty {
      var parameters: [String: Any] = [:]
      queryParameters.forEach { tuple in
        parameters[tuple.key] = tuple.value
      }
      parameters["key"] = apiKey
      
      let queryItems = parameters.compactMap { key, value -> URLQueryItem in
        URLQueryItem(name: key, value: "\(value)")
      }
      components.queryItems = queryItems.sorted { $0.name < $1.name }
    } else {
      components.queryItems = [
        URLQueryItem(name: "key", value: apiKey),
      ]
    }
    
    guard let url = components.url else {
      throw error
    }
    
    var urlRequest = URLRequest(url: url, cachePolicy: cachePolicy)
    urlRequest.httpMethod = httpMethod.rawValue
    urlRequest.httpBody = body
    
    urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    if let dataLength = body?.count {
      urlRequest.setValue("\(dataLength)", forHTTPHeaderField: "Content-Length")
    }
    
    if let requestHeaders = requestHeaders, !requestHeaders.isEmpty {
      for requestHeader in requestHeaders.enumerated() {
        urlRequest.setValue("\(requestHeader.element.value)", forHTTPHeaderField: requestHeader.element.key)
      }
    }
    return urlRequest
  }
  
  func encodeData<T>(_ value: T) -> Data? where T: Codable {
    do {
      return try JSONEncoder().encode(value)
    } catch let error as NSError {
      print("Failed to convert into a Codable: \(value) \(error) ")
      return nil
    }
  }
}
