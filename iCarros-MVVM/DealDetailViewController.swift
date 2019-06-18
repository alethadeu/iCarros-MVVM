//
//  DealDetailViewController.swift
//  iCarros-MVVM
//
//  Created by Alexandre Thadeu on 17/06/19.
//  Copyright © 2019 Alexandre Thadeu. All rights reserved.
//

import UIKit
import ImageSlideshow

class DealDetailViewController: UIViewController {
    
    //MARK: - Var & Outlets
    var deal: DealModel?

    @IBOutlet weak var imageSlideShow: ImageSlideshow! {
        didSet {
            let pageIndicator = UIPageControl()
            pageIndicator.currentPageIndicatorTintColor = UIColor.lightGray
            pageIndicator.pageIndicatorTintColor = UIColor.black
            
            imageSlideShow.pageIndicator = pageIndicator
            imageSlideShow.contentScaleMode = .scaleToFill
        }
    }
    @IBOutlet weak var makeAndModelLabel: UILabel!
    @IBOutlet weak var trimYearLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.setEmptyMessage("Não há opcionais")
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.configUi()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: - Config UI
    func configUi() {
        guard let deal = self.deal else {
            return
        }
        makeAndModelLabel.text = "\(deal.make) \(deal.model)"
        trimYearLabel.text = "\(deal.trim) \(deal.year)"
        imageSlideShow.setImageInputs(deal.photos)
    }
    
    //MARK: - Actions
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - TableView DataSource Extension
extension DealDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let equipments = deal?.equipments else {
            return 0
        }

        if equipments.equipmentsFormated.count > 0 {
            DispatchQueue.main.async {
                tableView.restore()
            }
        }
        
        return equipments.equipmentsFormated.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dealOptionsDetailTableViewCel", for: indexPath) as? DealOptionsDetailTableViewCell, let equipments = deal?.equipments?.equipmentsFormated else {
            return UITableViewCell()
        }
        
        let key   = Array(equipments)[indexPath.row].key
        let items = Array(equipments)[indexPath.row].value
        
        cell.setCell(category: key, items: items)
        
        return cell
    }
}
