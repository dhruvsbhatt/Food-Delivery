//
//  DashboardInteractor.swift
//  FoodDeliveryApp
//
//  Created by Dhruv Bhatt on 23/08/21.
//

import RxSwift
import RxCocoa
import Foundation
import ObjectMapper

class DashbaordInteractor: PresenterToInteractorProtocol {
    
    let disposeBag = DisposeBag()
    var presenter: InteractorToPresenterProtocol?
    
    func fetchMenu() {
        let menuService = MenuService()
        menuService.getMenu()
            .mapString()
            .subscribe({ event in
                switch event {
                case .next(let response):
                    print("Response = ", response)
                    let mapper = Mapper<Menu>()
                    if let menu = mapper.map(JSONString: response) {
                        self.presenter?.menuFetchSuccess(menuResponse: menu)
                    }
                case .error(let err):
                    print("Error = ", err)
                    self.presenter?.menuFetchFailed()
                case .completed:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
}
