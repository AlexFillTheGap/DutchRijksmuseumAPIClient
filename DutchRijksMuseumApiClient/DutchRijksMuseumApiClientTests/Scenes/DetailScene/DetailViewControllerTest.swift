//
//  DetailViewControllerTest.swift
//  DutchRijksMuseumApiClientTests
//
//  Created by Alejandro Fernandez Ruiz on 19/4/23.
//

import XCTest
@testable import DutchRijksMuseumApiClient

final class DetailViewControllerTest: XCTestCase {
  var sut: DetailViewController!

  override func setUpWithError() throws {
    do {
      try super.setUpWithError()

      let collectionDataItem = CollectionDataItem(
        artObjectId: "",
        title: "",
        image: "",
        width: 0,
        height: 0,
        author: ""
      )
      sut = DetailViewController(appServices: AppServices(), selectedItem: collectionDataItem)
    } catch {
      fatalError("error on setting up")
    }
  }

  func testSetupArtObject() throws {
    sut.setupArtObject(
      artObjects: DetailDataModel(
        selectedItemID: "fake id",
        imageUrl: "",
        title: "art object title",
        author: "art object author",
        description: "description")
    )
    XCTAssertTrue(sut != nil, "The method hasn't any accesible changes")
  }

  func testNeedToShowLoading() {
    sut.showLoading()
    let views = sut.view.subviews
    XCTAssertTrue(views.contains(UIViewController.loader), "loader view should be visible")
  }

  override func tearDownWithError() throws {
    sut = nil
  }
}
