//
//  CollectionDataModel.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation

public struct CollectionDataModel {
  var collectionDataList: [CollectionDataItem]
  var collectionVisitedList: [CollectionDataItem]
  var pageNumber: Int
}

public struct CollectionDataItem {
  let artObjectId: String
  let title: String
  let image: String
  let width: Int
  let height: Int
  let author: String
}
