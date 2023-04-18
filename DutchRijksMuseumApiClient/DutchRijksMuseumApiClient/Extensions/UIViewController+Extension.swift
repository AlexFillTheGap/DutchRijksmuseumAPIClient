//
//  UIViewController+Extension.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation
import UIKit

extension UIViewController {
  func showLoading(){
     LoadingView.alert = UIAlertController(title: nil, message: "loading_text".localized, preferredStyle: .alert)
    
    let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
    indicator.hidesWhenStopped = true
    indicator.style = UIActivityIndicatorView.Style.medium
    indicator.startAnimating();

    LoadingView.alert.view.addSubview(indicator)
    present(LoadingView.alert, animated: true, completion: nil)
  }

  func hideLoading(){
    LoadingView.alert.dismiss(animated: true, completion: nil)
  }
}
