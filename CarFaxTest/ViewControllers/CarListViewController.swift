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
        carTableView.dataSource = self
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
//                    print(self?.cars)
                    self?.carTableView.reloadData()
            }
            
            
        }
        
    }

}

extension CarListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = cars?.count else { return 0 }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let carCell = tableView.dequeueReusableCell(withIdentifier: kCarCellIdentifier, for: indexPath) as? CarCell else {
            return UITableViewCell()
        }
        
        let car = cars![indexPath.row]
        carCell.configureCell(car: car, tag: indexPath.row)
        carCell.delegate = self
        
        return carCell
    }
    
    
}

extension CarListViewController: CarDelegate {
    
    func callDealerAt(index: Int) {
        print(index)
    }
    
    
}
