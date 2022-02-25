//
//  RestaurantTableViewCell.swift
//  Yelpp
//
//  Created by Tony Razo on 2/21/22.
//

import UIKit
import AlamofireImage

class RestaurantTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantCategoryLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var restaurantImageView: UIImageView!
    
    func configure(with restaurant: Restaurant) {
        restaurantNameLabel.text = restaurant.name
        restaurantCategoryLabel.text = restaurant.type
        ratingLabel.text = "Rating \(restaurant.rating)"
        phoneNumberLabel.text = restaurant.phoneNumber
        restaurantImageView.af.setImage(withURL: URL(string: restaurant.imageURL)!)
    }

}
