//
//  CollectionRepository.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation

protocol CollectionRepositoryProtocol {
  func getVisited() -> CollectionRepositoryState
  func addVisitedElement(_ newElement: CollectionDataItem)
  func cleanVisitedElement()
}

enum CollectionRepositoryState {
  case empty
  case loaded(_ result: [CollectionDataItem])
  case failed(_ error: NSError)
}

class CollectionRepository: CollectionRepositoryProtocol {
  
  private var visited: [CollectionDataItem]
  private let collectionInfo: CollectionRepositoryState
  
  init() {
   visited = []
   collectionInfo = .empty
  }
  
  func addVisitedElement(_ newElement: CollectionDataItem) {
    visited.append(newElement)
  }
  
  func cleanVisitedElement() {
    visited = []
  }
  
  func getVisited() -> CollectionRepositoryState {
    return .loaded(visited)
  }
  
}
