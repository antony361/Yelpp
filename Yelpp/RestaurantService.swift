//
//  RestaurantService.swift
//  Yelpp
//
//  Created by Tony Razo on 2/21/22.
//

import Foundation

class RestaurantService {
    static let shared = RestaurantService()
    
    func fetchRestaurants(completion: @escaping(([Restaurant]) -> Void)) {
        
        let apikey = "jMBkZAy3iti91K0YdrISFJUToRGLEvhdMP2JUB2U_1jfzw-hSc7T5p0V0HyqyBZm1Gx-n3u2RsSSkGqzpKvAGih8fyga57FzbMIxU_EwCyhck5NZu03W7kyqXmoRYnYx"
        
        let url = URL(string: "https://api.yelp.com/v3/businesses/search?term=food&location=San+Francisco")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default,
                                 delegate: nil,
                                 delegateQueue: .main)
        
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("got an error")
                return
            }
            
            guard let data = data else {
                print("got no data")
                return
            }
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            let restaurantsRawData = dataDictionary["businesses"] as! [[String: Any]]
            var restaurants = [Restaurant]()
            for rawData in restaurantsRawData {
                let restaurant = Restaurant(name: rawData["name"] as! String,
                                            type: (rawData["categories"] as! [[String: String]])[0]["title"]!,
                                            rating: (rawData["rating"] as! NSNumber).intValue,
                                            phoneNumber: rawData["display_phone"] as! String,
                                            imageURL: rawData["image_url"] as! String)
                restaurants.append(restaurant)
            }
            completion(restaurants)
        }
        task.resume()
    }
}
