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
    let task = URLSession.shared.dataTask(with: req) { data, urlResponse, error in
      guard let response = urlResponse as? HTTPURLResponse else {
        completionHandler(nil, self.responseFormatError)
        return
      }
      if response.statusCode >= 400, response.statusCode <= 499 {
        let error = NSError(
          domain: "com.appstore.rijksmuseum.ServiceNetworkSession",
          code: response.statusCode,
          userInfo: [
            NSLocalizedDescriptionKey: "data_error_title".localized,
            NSLocalizedRecoverySuggestionErrorKey: "data_error_message".localized
          ]
        )
        completionHandler(nil, error)
        return
      } else if response.statusCode >= 500, response.statusCode <= 599 {
        let error = NSError(
          domain: "com.appstore.rijksmuseum.ServiceNetworkSession",
          code: response.statusCode,
          userInfo: [
            NSLocalizedDescriptionKey: "request_error_title".localized,
            NSLocalizedRecoverySuggestionErrorKey: "request_error_message".localized
          ]
        )
        completionHandler(nil, error)
        return
      }
      
      guard error == nil, let data = data else {
        var message = ""
        if let error = error as? URLError {
          switch error.code {
          case .timedOut:
            message = "request_timeout".localized
          default:
            message = "request_unknown".localized
          }
        }
        let error = NSError(
          domain: "com.appstore.rijksmuseum.ServiceNetworkSession",
          code: response.statusCode,
          userInfo: [
            NSLocalizedDescriptionKey: message
          ]
        )
        completionHandler(nil, error)
        return
      }
      completionHandler(data, nil)
    }
    task.resume()
  }
}

// MARK: - StatusCodeError

private struct StatusCodeError: Codable {
  let message: String
}
