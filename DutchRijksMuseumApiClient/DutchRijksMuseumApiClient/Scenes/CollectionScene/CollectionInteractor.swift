//
//  CollectionInteractor.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation

protocol CollectionInteractorProtocol {
  func selectArt(item: CollectionDataRequest)
  func loadArts()
  func nextPage()
  func previousPage()
}

class CollectionInteractor: CollectionInteractorProtocol {
  var presenter: CollectionPresenterProtocol?
  
  func selectArt(item: CollectionDataRequest) {
    
  }
  
  func loadArts() {
    
  }
  
  func nextPage() {
    
  }
  
  func previousPage() {
    
  }
  
}
