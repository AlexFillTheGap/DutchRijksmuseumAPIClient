//
//  CollectionInteractorTest.swift
//  DutchRijksMuseumApiClientTests
//
//  Created by Alejandro Fernandez Ruiz on 19/4/23.
//

import XCTest
@testable import DutchRijksMuseumApiClient

final class CollectionInteractorTest: XCTestCase {
  var sut: CollectionInteractor!
  var presenter: CollectionPresenterSpy!

  override func setUpWithError() throws {
    do {
      try super.setUpWithError()
      sut = CollectionInteractor(appServicesDependency: AppServiceSpy())
      presenter = CollectionPresenterSpy()
      sut.presenter = presenter
    } catch {
      fatalError("error on setting up")
    }
  }

  func testSelectArt() {
    sut.selectArt(item: CollectionDataRequest(
      selectedItem: CollectionDataItem(
        artObjectId: "fakeobject",
        title: "title",
        image: "image",
        width: 25,
        height: 25,
        author: "author"
      )
    ))
    XCTAssertTrue(presenter.performDetailNavigationSpy, "selection of item should navigate to detail page")
  }

  func testNextPage() {
    sut.nextPage()
    XCTAssertTrue(presenter.setupCollectionDataSpy)
    XCTAssertTrue(presenter.makeHideLoadingSpy)
    XCTAssertTrue(presenter.makeShowLoadingSpy)
  }

  func testFirstPage() {
    sut.firstPage()
    XCTAssertTrue(presenter.setupCollectionDataSpy)
    XCTAssertTrue(presenter.makeHideLoadingSpy)
    XCTAssertTrue(presenter.makeShowLoadingSpy)
  }

  override func tearDownWithError() throws {
    sut = nil
    presenter = nil
  }

  class CollectionPresenterSpy: CollectionPresenterProtocol {
    var setupCollectionDataSpy = false
    var makeShowLoadingSpy = false
    var makeHideLoadingSpy = false
    var performDetailNavigationSpy = false
    var showErrorAlertSpy = false

    func setupCollectionData(data: DutchRijksMuseumApiClient.CollectionDataResponse, pageNumber: Int) {
      setupCollectionDataSpy = true
    }

    func makeShowLoading() {
      makeShowLoadingSpy = true
    }

    func makeHideLoading() {
      makeHideLoadingSpy = true
    }

    func performDetailNavigation(detailItem: DutchRijksMuseumApiClient.CollectionDataItem) {
      performDetailNavigationSpy = true
    }

    func showErrorAlert(title: String?, message: String?) {
      showErrorAlertSpy = true
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
