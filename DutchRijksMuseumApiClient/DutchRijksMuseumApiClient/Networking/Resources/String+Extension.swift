//
//  String+Extension.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation

extension String {
  var localized: String {
    NSLocalizedString(self, bundle: Bundle.main, comment: "\(self)_comment")
  }
  
  func localized(_ args: CVarArg...) -> String {
    String(format: localized, args)
  }
}
