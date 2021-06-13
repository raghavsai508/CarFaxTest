//
//  ViewController.swift
//  CarFaxTest
//
//  Created by Raghav Sai Cheedalla on 6/11/21.
//

import UIKit

class CarListViewController: UIViewController {

    @IBOutlet weak var carTableView: UITableView!
    
    private let kCarCellIdentifier: String = String(describing: CarCell.self) // Cell Identifier
    private var cars: [Car]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        loadData()
    }
    
    /**
     Setting up the table view and registering the Car cell to the tableview
     */
    fileprivate func setupTableView() {
//        carTableView.delegate = self
//        carTableView.dataSource = self
        let cellNib = UINib(nibName: kCarCellIdentifier, bundle: nil) // Loading the Car cell from the Xib
        carTableView.register(cellNib, forCellReuseIdentifier: kCarCellIdentifier) // Registering the nib to the tableview with the identifier
        carTableView.estimatedRowHeight = 200
        carTableView.rowHeight = UITableView.automaticDimension // Automatic height is calculated
        carTableView.tableFooterView = UIView()
    }

    fileprivate func loadData() {
        let provider = ServiceProvider<CarService>()
        let carService = CarService(parameters: nil, httpMethod: .get, headers: nil)
        provider.load(service: carService, decodeType: CarContainer.self) { [weak self] (result) in
            
            switch result {
                case .failure(let error):
                    print(error)
                case .success(let carContainer):
                    self?.cars = carContainer.listings
                    print(self?.cars)
//                    self?.carTableView.reloadData()
            }
            
            
        }
        
    }

}

