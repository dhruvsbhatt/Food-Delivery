//
//  DashboardPresenter.swift
//  FoodDeliveryApp
//
//  Created by Dhruv Bhatt on 23/08/21.
//

import UIKit
import Foundation

class DashboardPresenter: ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterProtocol?
    
    func startFetchingMenu() {
        interactor?.fetchMenu()
    }
    
    func showCheckoutController(menu: [MenuModel], navigationController: UINavigationController) {
        router?.pushToCheckoutScreen(menu: menu, navigationConroller: navigationController)
    }
}

extension DashboardPresenter: InteractorToPresenterProtocol {
    func menuFetchSuccess(menuResponse: Menu) {
        view?.showMenu(menuArray: menuResponse)
    }
    
    func menuFetchFailed() {
        view?.showError()
    }
}
