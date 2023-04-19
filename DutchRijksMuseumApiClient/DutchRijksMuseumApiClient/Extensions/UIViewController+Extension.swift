//
//  UIViewController+Extension.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation
import UIKit

extension UIViewController {
  static let loader: UIView = {
    let loader = UIView()
    loader.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
    
    let activity = UIActivityIndicatorView(style: .large)
    activity.color = .orange
    activity.startAnimating()

    let label = UILabel()
    label.text = "loading_text".localized
    label.textAlignment = .center
    label.textColor = .orange
    
    loader.addSubview(activity)
    loader.addSubview(label)
    
    loader.translatesAutoresizingMaskIntoConstraints = false
    activity.translatesAutoresizingMaskIntoConstraints = false
    label.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      activity.centerYAnchor.constraint(equalTo: loader.centerYAnchor),
      activity.centerXAnchor.constraint(equalTo: loader.centerXAnchor),
      
      label.topAnchor.constraint(equalTo: activity.bottomAnchor, constant: 16),
      label.centerXAnchor.constraint(equalTo: activity.centerXAnchor)
    ])
    return loader
  }()
  
  func showLoading() {
    view.addSubview(UIViewController.loader)
    
    NSLayoutConstraint.activate([
      UIViewController.loader.topAnchor.constraint(equalTo: view.topAnchor),
      UIViewController.loader.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      UIViewController.loader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      UIViewController.loader.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }

  func hideLoading() {
    UIViewController.loader.removeFromSuperview()
  }
}
