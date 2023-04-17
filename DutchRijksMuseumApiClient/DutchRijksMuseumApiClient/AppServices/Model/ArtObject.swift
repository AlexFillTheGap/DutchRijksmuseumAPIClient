//
//  ArtObject.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation

struct ArtObject: Codable {
    let links: Links?
    let id, priref, objectNumber, language: String?
    let title: String?
    let webImage: WebImage?
  //  let colors: [Color]?
   // let colorsWithNormalization: [ColorsWithNormalization]?
   // let normalizedColors, normalized32Colors: [Color]?
    let titles: [String]?
    let description: String?
    let objectTypes, objectCollection: [String]?
 //   let principalMakers: [PrincipalMaker]?
    let plaqueDescriptionDutch, plaqueDescriptionEnglish, principalMaker: String?
  //  let acquisition: Acquisition?
    let materials: [String]?
    let productionPlaces: [String]?
   // let dating: Dating?
  //  let classification: Classification?
    let hasImage: Bool?
    let historicalPersons: [String]?
    let documentation: [String]?
    let principalOrFirstMaker: String?
 //   let dimensions: [Dimension]?
    let physicalMedium, longTitle, subTitle, scLabelLine: String?
  //  let label: Label?
    let showImage: Bool?
    let location: String?
}
