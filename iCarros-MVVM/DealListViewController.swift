//
//  ViewController.swift
//  iCarros-MVVM
//
//  Created by Alexandre Thadeu on 14/06/19.
//  Copyright © 2019 Alexandre Thadeu. All rights reserved.
//

import UIKit

class DealListViewController: UIViewController, InteractDealDelegate {
    
    //MARK: - Var & Outlets 
    let dataSource = DealDataSource()
    
    lazy var viewModel : DealViewModel = {
        let viewModel = DealViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let dealCollectionViewCell = UINib(nibName:"DealCollectionViewCell" , bundle: nil)
            collectionView.delegate = self
            collectionView.register(dealCollectionViewCell, forCellWithReuseIdentifier: CellIdentifier.collectionViewCell.dealList.rawValue)
            refreshControl.addTarget(self, action: #selector(refreshDeals(_:)), for: .valueChanged)
            collectionView.refreshControl = refreshControl
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            if let dealDetailVC = segue.destination as? DealDetailViewController, let deal = sender as? DealModel {
                dealDetailVC.deal = deal
            }
        }
    }
    
    //MARK: - Config Data
    func configData() {
        self.dataSource.delegate = self
        self.collectionView.dataSource = self.dataSource
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.collectionView.reloadData()
        }
        self.viewModel.fetchDeals()
    }
    
    //MARK: - Refresh Target
    @objc private func refreshDeals(_ sender: Any) {
        self.viewModel.fetchDeals()
        self.refreshControl.endRefreshing()
    }
    
    //MARK: - Interact Deal Delegate
    func returnDealWhenClickOnPhoto(deal: DealModel) {
        self.performSegue(withIdentifier:"goToDetail" , sender: deal)
    }
}

//MARK: - Collection Delegates
extension DealListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let baseHeight: CGFloat = 120
        let width = self.collectionView.frame.width - 30
        let height = (width * 0.75) + baseHeight
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let deal = dataSource.retrieveDeal(index: indexPath.row)
        self.performSegue(withIdentifier:"goToDetail" , sender: deal)
    }
}
