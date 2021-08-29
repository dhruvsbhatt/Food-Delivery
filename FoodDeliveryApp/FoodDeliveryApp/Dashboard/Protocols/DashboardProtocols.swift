//
//  DashboardProtocols.swift
//  FoodDeliveryApp
//
//  Created by Dhruv Bhatt on 23/08/21.
//

import UIKit
import Foundation

protocol ViewToPresenterProtocol: AnyObject {
    var view: PresenterToViewProtocol? { get set }
    var interactor: PresenterToInteractorProtocol? { get set }
    var router: PresenterToRouterProtocol? { get set}
    func startFetchingMenu()
    func showCheckoutController(navigationController: UINavigationController)
}

protocol PresenterToViewProtocol: AnyObject{
    func showMenu(menuArray: Menu)
    func showError()
}

protocol PresenterToRouterProtocol: AnyObject {
    func pushToCheckoutScreen(navigationConroller: UINavigationController)
}

protocol PresenterToInteractorProtocol: AnyObject {
    var presenter: InteractorToPresenterProtocol? {get set}
    func fetchMenu()
}

protocol InteractorToPresenterProtocol: AnyObject {
    func menuFetchSuccess(menuResponse: Menu)
    func menuFetchFailed()
}
