//
//  WebImage.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation

struct WebImage: Codable {
  let search: String?
  let guid: String?
  let offsetPercentageX: Int?
  let offsetPercentageY: Int?
  let width: Int?
  let height: Int?
  let url: String?
}
