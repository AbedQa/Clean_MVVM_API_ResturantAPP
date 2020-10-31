//
//  ViewController.swift
//  Resturant
//
//  Created by Abed Qassim on 10/3/20.
//

import UIKit

class ViewController: UIViewController , StoryboardInstantiatable {
    
    @IBOutlet weak var reloadButton:UIButton!
    private let resturantViewModel = ResturantViewModel()
    private let progress = ProgressHUD(title: "Loading", theme: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [progress].forEach(view.addSubview(_:))
        //        if  (Validator.manager.validate(text: "test", with: [.notEmpty,.validEmail]) ?? false) == false {
        //            print("not valid")
        //            return
        //        }
        getState()
        getCities()
        getRestaurant()
        getRestaurantById()
    }
    
    @IBAction func ReCallAPIS(_ sender: Any) {
        getState()
        getCities()
        getRestaurant()
        getRestaurantById()
    }
    
    
    //MAKE:  GETSTATE
    private func getState()  {
        progress.show()
        resturantViewModel.getState { [weak self] (error) in
            defer {
                self?.progress.hide()
            }
            if error != nil {
                print(error!)
            }else {
                print("Cities : \(self?.resturantViewModel.state?.cities ?? 0)")
                print("Restaurants : \(self?.resturantViewModel.state?.restaurants ?? 0)")
                print("Countries : \(self?.resturantViewModel.state?.countries ?? 0)")
            }
        }
    }
    
    
    //MAKE:  GETCITIES
    private func getCities()  {
        progress.show()
        resturantViewModel.getCities { [weak self] (error) in
            defer {
                self?.progress.hide()
            }
            if error != nil {
                print(error!)
            }else {
                print("Cities : \(self?.resturantViewModel.cityCount ?? 0)")
                print("City By Idex 0 : \(self?.resturantViewModel.getCity(with: 0) ?? "")")
            }
        }
    }
    
    //MAKE:  GETRESTAURANT
    private func getRestaurant()  {
        progress.show()
        resturantViewModel.getRestaurant(page: 1, country: "US") { [weak self] (error) in
            defer {
                self?.progress.hide()
            }
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
    }
    
    //MAKE:  GETRESTAURANTBYID
    private func getRestaurantById() {
        progress.show()
        resturantViewModel.getRestaurantById(id: 116272) { [weak self] (error) in
            defer {
                self?.progress.hide()
            }
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

