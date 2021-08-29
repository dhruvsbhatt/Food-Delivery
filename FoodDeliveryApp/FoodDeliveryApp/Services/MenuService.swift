//
//  MenuService.swift
//  FoodDeliveryApp
//
//  Created by Dhruv Bhatt on 24/08/21.
//

import Moya
import RxSwift
import RxMoya
import Foundation

class MenuService {
    
    let menuProvider = MoyaProvider<MenuApi>(stubClosure: MoyaProvider.delayedStub(2.0), plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))])
    
    
    func getMenu() -> Observable<Response> {
        return menuProvider.rx.request(.getMenu)
            .asObservable()
            .filterSuccessfulStatusCodes()
    }
}
