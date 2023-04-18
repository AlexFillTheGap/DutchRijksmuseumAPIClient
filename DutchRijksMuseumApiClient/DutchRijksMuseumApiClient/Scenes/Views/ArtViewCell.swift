//
//  ArtViewCell.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation
import UIKit

class ArtViewCell: UICollectionViewCell {
  
  let horizontalPadding: CGFloat = 15
  let verticalPadding: CGFloat = 8
  let topPadding: CGFloat = 80
  let bottomPadding: CGFloat = 0
  
  let artImageView = UIImageView()
  let titleView = UIView()
  let titleLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(artImageView)
    
    artImageView.translatesAutoresizingMaskIntoConstraints = false
    artImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    artImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    artImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    artImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    
    
    self.layer.cornerRadius = 20
    self.layer.masksToBounds = true
    
    
    titleView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    
    artImageView.addSubview(titleView)
    titleView.translatesAutoresizingMaskIntoConstraints = false
    titleView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    titleView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    titleView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    titleView.topAnchor.constraint(equalTo: bottomAnchor,constant: -30).isActive = true
    
    bringSubviewToFront(titleView)
    
    
    titleView.addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomPadding-8).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalPadding).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -horizontalPadding).isActive = true
    titleLabel.textColor = .white
    titleLabel.font = UIFont(name: "HelveticaNeue", size: CGFloat(10))
    titleLabel.numberOfLines = 2
    self.backgroundColor = .darkGray
  }
  
  
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
