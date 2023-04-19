//
//  CollectionViewController.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import UIKit

protocol CollectionViewControllerProtocol {
  func configureViewController(
    appService: (AppServiceCollectionProtocol & AppServiceDetailProtocol)
  ) -> CollectionViewController
  func setupArtObjects(artObjects: CollectionDataModel)
  func needToShowLoading()
  func needToHideLoading()
  func showAlert(title: String?, message: String?)
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
  
  var collectionDataSource: [[CollectionDataItem]] = []
  private var isRefreshing = false
  
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width - horizontalPadding * 2, height: 80)
    layout.itemSize = CGSize(width: UIScreen.main.bounds.width - horizontalPadding * 2, height: 200)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = .clear
    collectionView.showsVerticalScrollIndicator = false
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: verticalPadding),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomPadding)
    ])
    
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    collectionView.register(
      ArtViewCell.self,
      forCellWithReuseIdentifier: "cellId"
    )
    collectionView.register(
      CollectionHeader.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: "headerId"
    )
    
    interactor?.firstPage()
    isRefreshing = true
  }
  
  private func setupView() {
    view.backgroundColor = .black
    title = "collection_title".localized
    view.addSubview(collectionView)
  }
}

extension CollectionViewController: UICollectionViewDelegate,
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    collectionDataSource.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    viewForSupplementaryElementOfKind kind: String,
    at indexPath: IndexPath
  ) -> UICollectionReusableView {
    let headerView = collectionView.dequeueReusableSupplementaryView(
      ofKind: kind,
      withReuseIdentifier: "headerId",
      for: indexPath
    )
    guard let collectionHeaderView = headerView as? CollectionHeader else { return headerView }
    collectionHeaderView.titleLabel.text = String(format: "arts_header_title".localized, indexPath.section + 1)
    return collectionHeaderView
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    collectionDataSource[section].count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
    guard let artCell = cell as? ArtViewCell else { return cell }
    let item = collectionDataSource[indexPath.section][indexPath.row]
    
    artCell.configureCell(data: ArtViewCellData(artImageUrl: item.image, title: item.title))
    return artCell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let item = collectionDataSource[indexPath.section][indexPath.row]
    interactor?.selectArt(item: CollectionDataRequest(selectedItem: item))
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if collectionView.contentOffset.y >= (collectionView.contentSize.height - collectionView.bounds.size.height) {
      if !isRefreshing {
        isRefreshing = true
        interactor?.nextPage()
      }
    }
  }
}

extension CollectionViewController: CollectionViewControllerProtocol {
  func showAlert(title: String?, message: String?) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "alert_ok".localized, style: .default) { _ in
      alert.dismiss(animated: true)
    })
    present(alert, animated: true, completion: nil)
  }
  
  func needToShowLoading() {
    showLoading()
  }
  
  func needToHideLoading() {
    hideLoading()
  }
  
  func setupArtObjects(artObjects: CollectionDataModel) {
    collectionDataSource.append(artObjects.collectionDataList)
    collectionView.reloadData()
    isRefreshing = false
  }
  
  func configureViewController(
    appService: (AppServiceCollectionProtocol & AppServiceDetailProtocol)
  ) -> CollectionViewController {
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
    guard let appServices = interactor?.appServices as? AppServiceDetailProtocol else { return }
    let detailVC = DetailViewController(appServices: appServices, selectedItem: item)
    navigationController?.show(detailVC, sender: nil)
  }
}
