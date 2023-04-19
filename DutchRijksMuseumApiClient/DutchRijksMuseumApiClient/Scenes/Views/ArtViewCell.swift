//
//  ArtViewCell.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import Foundation
import UIKit

struct ArtViewCellData {
  let artImageUrl: String
  let title: String
}

class ArtViewCell: UICollectionViewCell {
  private let horizontalPadding: CGFloat = 15
  private let verticalPadding: CGFloat = 8
  private let topPadding: CGFloat = 80
  private let bottomPadding: CGFloat = 8
  
  private lazy var artImageView: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFill
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  private lazy var titleView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont(name: "HelveticaNeue", size: CGFloat(14))
    label.numberOfLines = 2
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureCell(data: ArtViewCellData) {
    titleLabel.text = data.title
    artImageView.download(from: data.artImageUrl)
  }
  
  private func setupView() {
    layer.cornerRadius = 20
    layer.masksToBounds = true
    backgroundColor = .darkGray
    contentView.addSubview(artImageView)
    contentView.addSubview(titleView)
    titleView.addSubview(titleLabel)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      artImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      artImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      artImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      artImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      
      titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      titleView.heightAnchor.constraint(equalToConstant: 40),
      
      titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: horizontalPadding),
      titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -horizontalPadding)
    ])
  }
}
