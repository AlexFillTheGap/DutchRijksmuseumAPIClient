//
//  DetailPresenterTest.swift
//  DutchRijksMuseumApiClientTests
//
//  Created by Alejandro Fernandez Ruiz on 19/4/23.
//

import XCTest
@testable import DutchRijksMuseumApiClient

final class DetailPresenterTest: XCTestCase {
  var sut: DetailPresenter!
  var view: DetailViewControllerSpy!

  override func setUpWithError() throws {
    do {
      try super.setUpWithError()
      sut = DetailPresenter()
      view = DetailViewControllerSpy()
      sut.view = view
    } catch {
      fatalError("error on tear down")
    }
  }

  func testSetupObjetData() {
    sut.setupObjetData(response: DetailDataResponse(
      artObject: ArtObject(
        links: nil,
        id: "",
        priref: "",
        objectNumber: "",
        language: "",
        title: "",
        webImage: nil,
        headerImage: nil,
        titles: [],
        description: "",
        objectTypes: [],
        objectCollection: [],
        principalMakers: [],
        plaqueDescriptionDutch: "",
        plaqueDescriptionEnglish: "",
        principalMaker: "",
        materials: [],
        productionPlaces: [],
        hasImage: true,
        historicalPersons: [],
        documentation: [],
        principalOrFirstMaker: nil,
        physicalMedium: "",
        longTitle: "",
        subTitle: "",
        scLabelLine: "",
        label: nil,
        showImage: true,
        location: nil
      )
    ))
    XCTAssertTrue(view.setupArtObjectSpy, "The presenter send the detail response to the view")
  }

  func testMakeShowLoading() {
    sut.makeShowLoading()
    XCTAssertTrue(view.needToShowLoadingSpy, "The presenter need to show the loading view")
  }

  func testMakeHideLoading() {
    sut.makeHideLoading()
    XCTAssertTrue(view.needToHideLoadingSpy, "The presenter need to hide the loading view")
  }

  func testShowErrorAlert() {
    sut.showErrorAlert(title: "fake title", message: "fake message")
    XCTAssertTrue(view.showAlertSpy, "The presenter wants to show an alert view with a message and title")
  }

  override func tearDownWithError() throws {
    sut = nil
    view = nil
  }

  class DetailViewControllerSpy: DetailViewControllerProtocol {
    var setupArtObjectSpy = false
    var needToShowLoadingSpy = false
    var needToHideLoadingSpy = false
    var showAlertSpy = false

    func setupArtObject(artObjects: DutchRijksMuseumApiClient.DetailDataModel) {
      setupArtObjectSpy = true
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
  }
}
