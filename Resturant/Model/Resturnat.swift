//
//  Resturant.swift
//  Resturant
//
//  Created by Abed Qassim on 10/3/20.
//

import Foundation
struct ResturantResponse: Codable {
    let totalEntries, perPage, currentPage: Int?
    let restaurants: [Restaurant]?
}
extension ResturantResponse {
    enum CodingKeys: String, CodingKey {
        case totalEntries = "total_entries"
        case perPage = "per_page"
        case currentPage = "current_page"
        case restaurants
    }
}
// MARK: - Restaurant
struct Restaurant: Codable {
    let id: Int?
    let name, address, city: String?
    let state: String?
    let area: String?
    let postalCode: String?
    let country: String?
    let phone: String?
    let lat, lng: Double?
    let price: Int?
    let reserveURL: String?
    let mobileReserveURL: String?
    let imageURL: String?
}
extension Restaurant {
    enum CodingKeys: String, CodingKey {
        case id, name, address, city, state, area
        case postalCode = "postal_code"
        case country, phone, lat, lng, price
        case reserveURL = "reserve_url"
        case mobileReserveURL = "mobile_reserve_url"
        case imageURL = "image_url"
    }
}
