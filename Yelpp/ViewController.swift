//
//  ViewController.swift
//  Yelpp
//
//  Created by Tony Razo on 2/21/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var restaurantTableView: UITableView!
    private var restaurants = [Restaurant]() {
        didSet {
            restaurantTableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantTableView.dataSource = self
        restaurantTableView.delegate = self
        RestaurantService.shared.fetchRestaurants { restaurants in
            self.restaurants = restaurants
            print(restaurants)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell") as? RestaurantTableViewCell
        else {
            return UITableViewCell()
        }
        cell.configure(with: restaurants[indexPath.row])
        return cell
    }


}

