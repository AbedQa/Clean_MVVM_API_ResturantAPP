//
//  MovieEndPoint.swift
//  NetworkLayer
//
//

import Foundation


enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum ResturantApi {
    case stats
    case cities
    case restaurants(page:Int,country:String)
    case restaurantItem(id:Int)
}

extension ResturantApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "http://opentable.herokuapp.com/api/"
        case .qa: return "http://opentable.herokuapp.com/api/"
        case .staging: return "http://opentable.herokuapp.com/api/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .stats:
            return "stats"
        case .cities:
            return "cities"
        case .restaurantItem(let id):
            return "restaurants/\(id)"
        case .restaurants( _, _ ):
            return "restaurants"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .restaurants(let page, let country):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["page":page,"country":country])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


