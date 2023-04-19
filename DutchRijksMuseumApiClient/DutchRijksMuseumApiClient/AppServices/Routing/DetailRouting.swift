//
//  DetailRouting.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 18/4/23.
//

import Foundation

public enum DetailRouting: APIRouter {
  case detail(artId: String)
  
  public var path: String {
    switch self {
    case .detail(artId: let artId):
      return "/collection/\(artId)?"
    }
  }
  
  public var httpMethod: APIHTTPMethod {
    .GET
  }
  
  public var userAuthentication: Bool {
    false
  }
}
