//
//  CollectionViewController.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import UIKit

protocol CollectionViewControllerProtocol {
  func configureViewController() -> CollectionViewController
}

class CollectionViewController: UIViewController {
  
  var interactor: CollectionInteractorProtocol?

    override func viewDidLoad() {
      super.viewDidLoad()
      self.view.backgroundColor = .orange
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CollectionViewController: CollectionViewControllerProtocol {
  
    func configureViewController() -> CollectionViewController {
      
      let interactor = CollectionInteractor()
      let presenter = CollectionPresenter()
      self.interactor = interactor
      interactor.presenter = presenter
      presenter.view = self

      return self
    }

}
