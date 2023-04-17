//
//  DetailInteractor.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation

protocol DetailInteractorProtocol {
  func selectArt(item: DetailDataRequest)
  func loadArts()
  func nextPage()
  func previousPage()
}

class DetailInteractor: DetailInteractorProtocol {
  var presenter: DetailPresenterProtocol?
  
  func selectArt(item: DetailDataRequest) {
    
  }
  
  func loadArts() {
    
  }
  
  func nextPage() {
    
  }
  
  func previousPage() {
    
  }
  
}
