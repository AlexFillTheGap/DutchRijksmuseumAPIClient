//
//  NetworkSession.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation

protocol NetworkSession: AnyObject {
  func doRequest(for req: URLRequest, completionHandler : @escaping (Data?, NSError?)-> Void)
}
