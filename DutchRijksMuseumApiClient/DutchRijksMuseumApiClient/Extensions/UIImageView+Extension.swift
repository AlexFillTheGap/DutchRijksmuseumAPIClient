//
//  UIImageView+Extension.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation
import UIKit

extension UIImageView {
  func download(from link: String) {
    guard let url = URL(string: link) else { return }
    download(url: url)
  }
  
  func download(url: URL) {
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url) {
        if let image = UIImage(data: data) {
          DispatchQueue.main.async {
            self?.image = image
          }
        }
      }
    }
  }
}
