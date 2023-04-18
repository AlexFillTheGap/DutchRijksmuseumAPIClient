//
//  CollectionDataResponse.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation

public struct CollectionDataResponse {
  var collectionDataList: [CollectionResponseItem]
  var collectionVisitedList: CollectionRepositoryState
  var pageNumber: Int
}

public struct CollectionResponseItem {
  let artObjectId: String
  let title: String
  let image: String
  let width: Int
  let height: Int
  let author: String
}
