//
//  DashboardEntity.swift
//  FoodDeliveryApp
//
//  Created by Dhruv Bhatt on 23/08/21.
//

import RxSwift
import Foundation
import ObjectMapper

//typealias MenuArray = [MenuModel]

class MenuModel: Mappable {
    
    internal var name: String?
    internal var ingredients: String?
    internal var dimensions: String?
    internal var price: Int?
    internal var image: String?

    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        ingredients <- map["ingredients"]
        dimensions <- map["dimensions"]
        price <- map["price"]
        image <- map["image"]
    }
}

class Menu: Mappable {
    
    var menu: [MenuModel]?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        menu <- map["menu"]
    }
}
