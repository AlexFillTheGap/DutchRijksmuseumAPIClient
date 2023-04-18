//
//  CollectionHeader.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import UIKit

/// Defines methods for creating view.
protocol ViewSetable {

    /// Creates view hierarchy.
    func setupViews()

    /// Creates anchors between views.
    func setupConstraints()
}

class CollectionHeader: UICollectionReusableView {

    var titleLabel: UILabel = {
        let label = UILabel()
        label.custom(title: "Title", font: .systemFont(ofSize: 20), titleColor: .black, textAlignment: .center, numberOfLines: 1)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CollectionHeader : ViewSetable {

    func setupViews() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundColor = .white
        addSubview(titleLabel)
    }

    func setupConstraints() {
        // Title label constraints.
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}

extension UILabel {
  
  func custom(title: String, font: UIFont, titleColor: UIColor, textAlignment: NSTextAlignment, numberOfLines: Int) {
    self.text = title
    self.textAlignment = textAlignment
    self.font = font
    self.textColor = titleColor
    self.numberOfLines = numberOfLines
    self.adjustsFontSizeToFitWidth = true
    self.translatesAutoresizingMaskIntoConstraints = false
  }
  
  
}
