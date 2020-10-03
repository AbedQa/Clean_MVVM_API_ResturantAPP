//
//  ViewController.swift
//  Resturant
//
//  Created by Abed Qassim on 10/3/20.
//

import UIKit

class ViewController: UIViewController {
    private let resturantViewModel = ResturantViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        resturantViewModel.getState { [weak self] (error) in
            if error != nil {
                print(error!)
            }else {
                print("Cities : \(self?.resturantViewModel.state?.cities ?? 0)")
                print("Restaurants : \(self?.resturantViewModel.state?.restaurants ?? 0)")
                print("Countries : \(self?.resturantViewModel.state?.countries ?? 0)")
            }
        }
        resturantViewModel.getCities { [weak self] (error) in
            if error != nil {
                print(error!)
            }else {
                print("Cities : \(self?.resturantViewModel.cityCount ?? 0)")
                print("City By Idex 0 : \(self?.resturantViewModel.getCity(with: 0) ?? "")")
            }
        }
        resturantViewModel.getRestaurant(page: 1, country: "US") { [weak self] (error) in
            if error != nil {
                print(error!)
            }else {
                print("ResturantsCount : \(self?.resturantViewModel.resturantsCount ?? 0)")
                guard let resturant = self?.resturantViewModel.getRestaurant(with: 0) else {
                    return
                }
                print("Resurant By Idex 0 : \(resturant))")
            }
        }
        resturantViewModel.getRestaurantById(id: 116272) { [weak self] (error) in
            if error != nil {
                print(error!)
            }else {
                guard let resturant = self?.resturantViewModel.currentResturant else {
                    return
                }
                print("Resurant: \(resturant))")
            }
        }
    }
    
    
}

