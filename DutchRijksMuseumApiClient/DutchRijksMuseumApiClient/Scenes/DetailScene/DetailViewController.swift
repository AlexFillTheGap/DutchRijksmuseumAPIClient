//
//  DetailViewController.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import UIKit

protocol DetailViewControllerProtocol {
  func setupArtObject(artObjects: DetailDataModel)
  func needToShowLoading()
  func needToHideLoading()
  func showAlert(title: String?, message: String?)
}

class DetailViewController: UIViewController {
  private var interactor: DetailInteractorProtocol?
  
  private let titleHeight: CGFloat = 30
  private let horizontalPadding: CGFloat = 15
  private let verticalPadding: CGFloat = 16
  private let topPadding: CGFloat = 90
  private let bottomPadding: CGFloat = 30
  private let spacing: CGFloat = 12
  
  private let selectedItem: CollectionDataItem
  
  private var objectImage: UIImageView = {
    UIImageView()
  }()
  
  private let scrollView: UIScrollView = {
    UIScrollView()
  }()
  
  private lazy var scrollStackViewContainer: UIStackView = {
    let view = UIStackView()
    view.axis = .vertical
    view.spacing = spacing
    view.distribution = .equalSpacing
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var authorTitle: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.text = "detail_author_title".localized
    label.textColor = .orange
    label.font = UIFont(name: "HelveticaNeue", size: CGFloat(20))
    return label
  }()
  
  private lazy var authorValue: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.textColor = .white
    label.font = UIFont(name: "HelveticaNeue", size: CGFloat(18))
    return label
  }()
  
  private lazy var descriptionTitle: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.text = "detail_description_title".localized
    label.textColor = .orange
    label.font = UIFont(name: "HelveticaNeue", size: CGFloat(20))
    return label
  }()
  
  private lazy var descriptionValue: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.numberOfLines = 0
    label.textColor = .white
    label.font = UIFont(name: "HelveticaNeue", size: CGFloat(18))
    return label
  }()
  
  required init(appServices: AppServices, selectedItem: CollectionDataItem) {
    self.selectedItem = selectedItem
    super.init(nibName: nil, bundle: nil)
    let interactor = DetailInteractor(appServicesDependency: appServices)
    let presenter = DetailPresenter()
    self.interactor = interactor
    interactor.presenter = presenter
    presenter.view = self
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    objectImage.translatesAutoresizingMaskIntoConstraints = false
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollStackViewContainer.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      objectImage.topAnchor.constraint(equalTo: view.topAnchor, constant: topPadding),
      objectImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding),
      objectImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding),
      objectImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2),
      
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.topAnchor.constraint(equalTo: objectImage.bottomAnchor, constant: bottomPadding),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
      scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
    ])
    
    interactor?.loadArtDetais(objectId: selectedItem.artObjectId)
  }
  
  private func setupView() {
    self.navigationController?.navigationBar.tintColor = .orange
    view.addSubview(objectImage)
    view.addSubview(scrollView)
    scrollView.addSubview(scrollStackViewContainer)
    
    scrollStackViewContainer.addArrangedSubview(authorTitle)
    scrollStackViewContainer.addArrangedSubview(authorValue)
    scrollStackViewContainer.addArrangedSubview(descriptionTitle)
    scrollStackViewContainer.addArrangedSubview(descriptionValue)
    
    view.backgroundColor = .black
  }
}

extension DetailViewController: DetailViewControllerProtocol {
  func showAlert(title: String?, message: String?) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "alert_ok".localized, style: .default) { _ in
      alert.dismiss(animated: true)
      self.navigationController?.popViewController(animated: true)
    })
    present(alert, animated: true, completion: nil)
  }
  
  func setupArtObject(artObjects: DetailDataModel) {
    title = artObjects.title
    objectImage.download(from: artObjects.imageUrl)
    authorValue.text = artObjects.author
    descriptionValue.text = artObjects.description
  }
  
  func needToShowLoading() {
    showLoading()
  }
  
  func needToHideLoading() {
    hideLoading()
  }
}
