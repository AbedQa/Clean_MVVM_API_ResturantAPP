//
//  ResturantViewModel.swift
//  Resturant
//
//  Created by Abed Qassim on 10/3/20.
//

import Foundation
class ResturantViewModel {
    private let networkManager = NetworkManager()
    private var stateItem:State?
    private var cityList:[String] = []
    private var restaurantList:[Restaurant] = []
    private var restaurantItem:Restaurant?
    private var currentPage:Int = 0
    private var pageCount:Int = 0
    var hasNextPage:Bool {
        return currentPage < pageCount
    }
    var state:State? {
        return stateItem
    }
    var currentResturant:Restaurant? {
        return restaurantItem
    }
    var cityCount:Int {
        return cityList.count
    }
    func getCity(with index:Int) -> String {
        return cityList[index]
    }
    var resturantsCount:Int {
        return restaurantList.count
    }
    func getRestaurant(with index:Int) -> Restaurant {
        return restaurantList[index]
    }
    
}
extension ResturantViewModel {
    func getState(callBack:@escaping APICallBack)  {
        networkManager.getAPI(decodabel: State.self, resturnatApi: .stats) { (response, error) in
            if error != nil {
                callBack(error)
            }else {
                self.stateItem = response
                callBack(nil)
            }
        }
    }
    func getCities(callBack:@escaping APICallBack)  {
        networkManager.getAPI(decodabel: Cities.self, resturnatApi: .cities) { (response, error) in
            if error != nil {
                callBack(error)
            }else {
                self.cityList = response?.cities ?? []
                callBack(nil)
            }
        }
    }
    func getRestaurant(page:Int,country:String,callBack:@escaping APICallBack)  {
        networkManager.getAPI(decodabel: ResturantResponse.self, resturnatApi: .restaurants(page: page, country: country)) { (response, error) in
            if error != nil {
                callBack(error)
            }else {
                self.currentPage = response?.currentPage ?? 0
                self.pageCount = response?.perPage ?? 0
                self.restaurantList = response?.restaurants ?? []
                callBack(nil)
            }
        }
    }
    func getRestaurantById(id:Int,callBack:@escaping APICallBack)  {
        networkManager.getAPI(decodabel: Restaurant.self, resturnatApi: .restaurantItem(id: id)) { (response, error) in
            if error != nil {
                callBack(error)
            }else {
                self.restaurantItem = response
                callBack(nil)
            }
        }
    }
}
