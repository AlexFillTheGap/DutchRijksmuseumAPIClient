//
//  HeaderImage.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 18/4/23.
//

import Foundation


struct HeaderImage: Codable {
  let guid: String?
  let offsetPercentageX: Int?
  let offsetPercentageY: Int?
  let width: Int?
  let height: Int?
  let url: String?
}
