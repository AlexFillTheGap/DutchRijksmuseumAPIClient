//
//  CollectionRepository.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation

protocol CollectionRepositoryProtocol {
  func getVisited() -> CollectionRepositoryState
}

enum CollectionRepositoryState {
  case empty
  case loaded(_ result: [CollectionDataModel])
  case failed(_ error: NSError)
}

class CollectionRepository: CollectionRepositoryProtocol {
  
  private var visited: [CollectionDataModel]
  private let collectionInfo: CollectionRepositoryState
  
  init() {
   visited = []
   collectionInfo = .empty
  }
  
  func getVisited() -> CollectionRepositoryState {
    return .loaded(visited)
  }
  
}
