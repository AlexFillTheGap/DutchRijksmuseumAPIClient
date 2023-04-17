//
//  CollectionRouting.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation

public enum CollectionRouting: APIRouter {
  
  case collection
  case collectionPage(page: Int)
  
  public var path: String {
    switch self {
    case .collection:
      return "/collection?"
    case .collectionPage(page: Int)
      return "/collection?p=\(page)"
    }
    
  }
  
  public var httpMethod: APIHTTPMethod {
    .GET
  }
  
  public var userAuthentication: Bool {
    false
  }
  
}
