//
//  CollectionViewController.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import UIKit

protocol CollectionViewControllerProtocol {
  func configureViewController(appService: AppServices) -> CollectionViewController
  func setupArtObjects(artObjects: CollectionDataModel)
  func needToShowLoading()
  func needToHideLoading()
}

protocol CollectionViewControllerNavigation {
  func goToDetail(item: CollectionDataItem)
}

class CollectionViewController: UIViewController {
  
  var interactor: CollectionInteractorProtocol?
  
  let titleHeight: CGFloat = 30
  let horizontalPadding: CGFloat = 15
  let verticalPadding: CGFloat = 16
  let topPadding: CGFloat = 80
  let bottomPadding: CGFloat = 8
  
  var collectionDataSource: [CollectionDataItem] = []
  var visitedDataSources:[CollectionDataItem] = []
  
  private var titleLabel: UILabel = {
    let label = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.width/2, width: UIScreen.main.bounds.width, height: 50))
    label.textAlignment = .center
    label.text = "collection_title".localized
    return label
  }()
  
  private var minusButton: UIButton = {
    let minusButton = UIButton(frame: CGRect(x: 20, y: 20, width: 200, height: 60))
    minusButton.setTitle("minus_button_title".localized, for: .normal)
    minusButton.backgroundColor = .white
    minusButton.setTitleColor(UIColor.black, for: .normal)
    
    minusButton.layer.cornerRadius = 8
    minusButton.layer.cornerCurve = .continuous

    return minusButton
  }()
  
  private var plusButton: UIButton = {
    let plusButton = UIButton(frame: CGRect(x: 20, y: 20, width: 200, height: 60))
    plusButton.setTitle("plus_button_title".localized, for: .normal)
    plusButton.backgroundColor = .white
    plusButton.setTitleColor(UIColor.black, for: .normal)
    
    plusButton.layer.cornerRadius = 8
    plusButton.layer.cornerCurve = .continuous
    return plusButton
  }()
  
  private var pageLabel: UILabel = {
    let label = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.width/2, width: UIScreen.main.bounds.width, height: 50))
    label.textAlignment = .center
    label.textColor = .white
    return label
  }()
  
  private var buttonStack: UIStackView = {
    let hstack = UIStackView()
    hstack.axis = .horizontal
    hstack.distribution = .fillEqually
    return hstack
  }()
  
  private var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    
    view.addSubview(titleLabel)
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.heightAnchor.constraint(equalToConstant: titleHeight).isActive = true
    titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: topPadding).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding).isActive = true
    
    
    view.addSubview(buttonStack)
    buttonStack.translatesAutoresizingMaskIntoConstraints = false
    buttonStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: verticalPadding).isActive = true
    buttonStack.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
    buttonStack.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
    
    view.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: verticalPadding).isActive = true
    collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding).isActive = true
    collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomPadding).isActive = true
    
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(ArtViewCell.self, forCellWithReuseIdentifier: "cellId")
    collectionView.register(CollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
    
    self.interactor?.firstPage()
  }
  
  private func setupView() {
    self.navigationController?.setNavigationBarHidden(true, animated: true)
    view.backgroundColor = .black
    collectionView.backgroundColor = .clear
    collectionView.showsVerticalScrollIndicator = false
    
    titleLabel.textColor = .orange
    titleLabel.font = UIFont(name: "HelveticaNeue", size: CGFloat(30))
    
    pageLabel.textColor = .orange
    titleLabel.font = UIFont(name: "HelveticaNeue", size: CGFloat(22))
  
    
    buttonStack.addArrangedSubview(minusButton)
    buttonStack.addArrangedSubview(pageLabel)
    buttonStack.addArrangedSubview(plusButton)
    
    minusButton.addTarget(self, action: #selector(minusAction), for: .touchUpInside)
    plusButton.addTarget(self, action: #selector(plusAction), for: .touchUpInside)
  }
  
  @objc private func minusAction(_ sender: UIButton?) {
  
    self.interactor?.previousPage()
  }
  
  @objc private func plusAction(_ sender: UIButton?) {

    self.interactor?.nextPage()
  }
  
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! CollectionHeader
    headerView.titleLabel.text = indexPath.section == 0 ? "arts_header_title".localized : "visited_header_title".localized
    return headerView
    
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if section == 0 {
      return collectionDataSource.count
    } else {
      return visitedDataSources.count
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ArtViewCell
    
    let item: CollectionDataItem = indexPath.section == 0 ? collectionDataSource[indexPath.row] : visitedDataSources[indexPath.row]
    
    cell.artImageView.downloaded(from: item.image)
    cell.titleLabel.text = item.title
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let item: CollectionDataItem = indexPath.section == 0 ? collectionDataSource[indexPath.row] : visitedDataSources[indexPath.row]
    visitedDataSources.append(item)
    interactor?.selectArt(item: CollectionDataRequest(selectedItem: item))
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let item: CollectionDataItem = collectionDataSource[indexPath.row]
    let halfwidthScreen = view.frame.width/2.75
    let cellWidth = halfwidthScreen
    let cellHeight = (halfwidthScreen * CGFloat(item.height)) / CGFloat(item.width)
    return CGSize(width: cellWidth, height: cellHeight)
  }
}

extension CollectionViewController: CollectionViewControllerProtocol {
  func needToShowLoading() {
    self.showLoading()
  }
  
  func needToHideLoading() {
    self.hideLoading()
  }
  
  func setupArtObjects(artObjects: CollectionDataModel) {
    collectionDataSource = artObjects.collectionDataList
    visitedDataSources = artObjects.collectionVisitedList
    pageLabel.text = "\(artObjects.pageNumber)"
    collectionView.reloadData()
  }
  
  func configureViewController(appService: AppServices) -> CollectionViewController {
    
    let interactor = CollectionInteractor(appServicesDependency: appService)
    let presenter = CollectionPresenter()
    self.interactor = interactor
    interactor.presenter = presenter
    presenter.view = self
    
    return self
  }
  
}

extension CollectionViewController: CollectionViewControllerNavigation {
  func goToDetail(item: CollectionDataItem) {
    
  }
}
