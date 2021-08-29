//
//  MenuAPIService.swift
//  FoodDeliveryApp
//
//  Created by Dhruv Bhatt on 24/08/21.
//

import Moya
import RxSwift
import Foundation

enum MenuApi {
    case getMenu
}

extension MenuApi: TargetType {
    var baseURL: URL {
        let url = "www.google.com"
        return URL(string: url)!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        let url = Bundle.main.url(forResource: "Menu", withExtension: "json")
//        let str = "{\"id\":1,\"title\":\"How I Mock Data with Moya\",\"price\":20.19}"
        let strData = try? Data(contentsOf: url!)
        return strData!
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}
