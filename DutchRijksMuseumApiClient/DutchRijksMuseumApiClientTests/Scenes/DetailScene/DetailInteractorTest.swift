//
//  DetailInteractorTest.swift
//  DutchRijksMuseumApiClientTests
//
//  Created by Alejandro Fernandez Ruiz on 19/4/23.
//

import XCTest
@testable import DutchRijksMuseumApiClient

final class DetailInteractorTest: XCTestCase {
  var sut: DetailInteractor!
  var presenter: DetailPresenterSpy!

  override func setUpWithError() throws {
    do {
      try super.setUpWithError()
      sut = DetailInteractor(appServicesDependency: AppServiceSpy())
      presenter = DetailPresenterSpy()
      sut.presenter = presenter
    } catch {
      fatalError("error on setting up")
    }
  }

  func testLoadArtDetais() {
    sut.loadArtDetais(objectId: "fakeid")
    XCTAssertTrue(presenter.setupObjectDataSpy, "the interactor request should manipulate data and pass to presenter")
  }

  override func tearDownWithError() throws {
    sut = nil
    presenter = nil
  }

  class DetailPresenterSpy: DetailPresenterProtocol {
    var setupObjectDataSpy = false
    var makeShowLoadingSpy = false
    var makeHideLoadingSpy = false
    var showErrorAlertSpy = false

    func setupObjetData(response: DetailDataResponse) {
      setupObjectDataSpy = true
    }

    func makeShowLoading() {
      makeShowLoadingSpy = true
    }

    func makeHideLoading() {
      makeHideLoadingSpy = true
    }

    func showErrorAlert(title: String?, message: String?) {
      showErrorAlertSpy = true
    }
  }

  class AppServiceSpy: AppServiceDetailProtocol {
    func detailedArt(objectId: String, completionHandler: @escaping (DetailDataResponse?, NSError?) -> Void) {
      let data = DetailDataResponse(
        artObject: ArtObject(
          links: nil,
          id: "fakeid",
          priref: "fakepriref",
          objectNumber: "fakenumber",
          language: "en",
          title: "Fake title",
          webImage: nil,
          headerImage: nil, titles: [],
          description: nil,
          objectTypes: [],
          objectCollection: [],
          principalMakers: [],
          plaqueDescriptionDutch: nil,
          plaqueDescriptionEnglish: nil,
          principalMaker: nil,
          materials: [],
          productionPlaces: [],
          hasImage: true,
          historicalPersons: [],
          documentation: [],
          principalOrFirstMaker: nil,
          physicalMedium: nil,
          longTitle: nil,
          subTitle: nil,
          scLabelLine: nil,
          label: nil,
          showImage: false,
          location: nil
        )
      )
      completionHandler(data, nil)
    }
  }
}
