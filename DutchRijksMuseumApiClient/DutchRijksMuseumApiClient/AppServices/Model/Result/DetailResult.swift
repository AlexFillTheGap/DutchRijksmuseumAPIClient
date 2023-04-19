//
//  DetailResult.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 18/4/23.
//

import Foundation

struct DetailResult: Codable {
  let elapsedMilliseconds: Int?
  let count: Int?
  let artObject: ArtObject?
}
