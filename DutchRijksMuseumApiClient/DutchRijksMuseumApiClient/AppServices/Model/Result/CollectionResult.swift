//
//  CollectionResult.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation

struct CollectionResult: Codable {
  
    let elapsedMilliseconds: Int?
    let count: Int?
    let artObjects: [ArtObject]?
  
}
