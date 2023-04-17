//
//  ServiceNetworkSession.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//


import Foundation

public class ServiceNetworkSession: NetworkSession {
  private let responseFormatError = NSError(
    domain: "com.appstore.rijksmuseum.ServiceNetworkSession",
    code: 0,
    userInfo: [
      NSLocalizedDescriptionKey: "response_format_title".localized,
      NSLocalizedRecoverySuggestionErrorKey: "response_format_message".localized
    ]
  )
  
  func doRequest(for req: URLRequest, completionHandler: @escaping (Data?, NSError?) -> Void) {
    
      let task = URLSession.shared.dataTask(with: req) { data, _, error in
        print("Inside URLSession.shared.dataTask.....")
        
        guard error == nil, let data = data else {
          DispatchQueue.main.async {
            completionHandler(nil, NSError(domain: "com.appstore.rijksmuseum.ServiceNetworkSession", code: 0))
          }
          return
        }
        
        do {
          DispatchQueue.main.async {
            completionHandler(data, nil)
          }
        } catch _ {
          DispatchQueue.main.async {
            completionHandler(nil, NSError(domain: "com.appstore.rijksmuseum.ServiceNetworkSession", code: 1))
          }
        }
        
        
      }
      task.resume()
    
  }
}

// MARK: - StatusCodeError

private struct StatusCodeError: Codable {
  let message: String
}
