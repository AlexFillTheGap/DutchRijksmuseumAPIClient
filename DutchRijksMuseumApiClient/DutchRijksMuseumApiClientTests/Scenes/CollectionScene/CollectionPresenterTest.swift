//
//  CollectionPresenterTest.swift
//  DutchRijksMuseumApiClientTests
//
//  Created by Alejandro Fernandez Ruiz on 19/4/23.
//

import XCTest
@testable import DutchRijksMuseumApiClient

final class CollectionPresenterTest: XCTestCase {
  var sut: CollectionPresenter!
  var view: CollectionViewControllerSpy!

  override func setUpWithError() throws {
    do {
      try super.setUpWithError()
      sut = CollectionPresenter()
      view = CollectionViewControllerSpy()
      sut.view = view
    } catch {
      fatalError("error on tear down")
    }
  }

  func testSetupCollectionData() {
    sut.setupCollectionData(data: CollectionDataResponse(collectionDataList: [], pageNumber: 1), pageNumber: 1)
    XCTAssertTrue(view.setupArtObjectsSpy, "the view will setup collection view with the list of elements provided")
  }

  func testMakeShowLoading() {
    sut.makeShowLoading()
    XCTAssertTrue(view.needToShowLoadingSpy, "the view will show the loading view")
  }

  func testMakeHideLoading() {
    sut.makeHideLoading()
    XCTAssertTrue(view.needToHideLoadingSpy, "the view will hide the loading view")
  }

  func testPerformDetailNavigation() {
    sut.performDetailNavigation(detailItem: CollectionDataItem(
      artObjectId: "",
      title: "",
      image: "",
      width: 0,
      height: 0,
      author: "")
    )
    XCTAssertTrue(view.goToDetailSpy, "the view should navigate to the detail view")
  }

  func testShowErrorAlert() {
    sut.showErrorAlert(title: "title", message: "message")
    XCTAssertTrue(view.showAlertSpy, "The presenter request the view to show the alert view with title and message")
  }

  override func tearDownWithError() throws {
    sut = nil
    view = nil
  }

  class CollectionViewControllerSpy: CollectionViewControllerProtocol, CollectionViewControllerNavigation {
    var configureViewControllerSpy = false
    var setupArtObjectsSpy = false
    var needToShowLoadingSpy = false
    var needToHideLoadingSpy = false
    var showAlertSpy = false
    var goToDetailSpy = false

    func configureViewController(
      appService: (AppServiceCollectionProtocol & AppServiceDetailProtocol)
    ) -> DutchRijksMuseumApiClient.CollectionViewController {
      configureViewControllerSpy = true
      return CollectionViewController()
    }

    func setupArtObjects(artObjects: DutchRijksMuseumApiClient.CollectionDataModel) {
      setupArtObjectsSpy = true
    }

    func needToShowLoading() {
      needToShowLoadingSpy = true
    }

    func needToHideLoading() {
      needToHideLoadingSpy = true
    }

    func showAlert(title: String?, message: String?) {
      showAlertSpy = true
    }

    func goToDetail(item: DutchRijksMuseumApiClient.CollectionDataItem) {
      goToDetailSpy = true
    }

  }

  class AppServiceSpy: AppServiceCollectionProtocol {
    func collectionPage(
      pageNumber: Int,
      completionHandler: @escaping (DutchRijksMuseumApiClient.CollectionDataResponse?, NSError?) -> Void) {
      let data = CollectionDataResponse(collectionDataList: [], pageNumber: 1)
      completionHandler(data, nil)
    }
  }
}
