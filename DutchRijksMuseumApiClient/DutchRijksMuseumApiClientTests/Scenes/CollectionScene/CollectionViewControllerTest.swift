//
//  CollectionViewControllerTest.swift
//  DutchRijksMuseumApiClientTests
//
//  Created by Alejandro Fernandez Ruiz on 19/4/23.
//

import XCTest
@testable import DutchRijksMuseumApiClient

final class CollectionViewControllerTest: XCTestCase {
  var sut: CollectionViewController!
  var interactor: CollectionInteractorSpy!

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    do {
      try super.setUpWithError()

      sut = CollectionViewController()
      interactor = CollectionInteractorSpy()
      sut.interactor = interactor
    } catch {
      fatalError("error on setting up")
    }
  }

  func testSetupArtObjects(artObjects: CollectionDataModel) {
    sut.setupArtObjects(artObjects:
                          CollectionDataModel(
                            collectionDataList: [],
                            pageNumber: 1)
    )
  }

  func testNeedToShowLoading() {
    sut.showLoading()
    let views = sut.view.subviews
    XCTAssertTrue(views.contains(UIViewController.loader), "loader view should be visible")
  }

  func testNeedToHideLoading() {
    sut.hideLoading()
    let views = sut.view.subviews
    XCTAssertFalse(views.contains(UIViewController.loader), "loader view shouldn't be visible")
  }

  override func tearDownWithError() throws {
    sut = nil
    interactor = nil
  }

  class CollectionInteractorSpy: CollectionInteractorProtocol {
    var appServices: DutchRijksMuseumApiClient.AppServiceCollectionProtocol = AppServiceSpy()
    var selectArtSpy = false
    var nextPageSpy = false
    var firstPageSpy = false

    func selectArt(item: DutchRijksMuseumApiClient.CollectionDataRequest) {
      selectArtSpy = true
    }

    func nextPage() {
      nextPageSpy = true
    }

    func firstPage() {
      firstPageSpy = true
    }
  }

  class AppServiceSpy: AppServiceCollectionProtocol {
    func collectionPage(
      pageNumber: Int,
      completionHandler: @escaping (DutchRijksMuseumApiClient.CollectionDataResponse?, NSError?) -> Void) {
        completionHandler(CollectionDataResponse(collectionDataList: [], pageNumber: 1), nil)
      }
  }
}
