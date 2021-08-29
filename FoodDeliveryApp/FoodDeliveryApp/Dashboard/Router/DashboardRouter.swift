//
//  DashboardRouter.swift
//  FoodDeliveryApp
//
//  Created by Dhruv Bhatt on 23/08/21.
//

import UIKit
import Foundation

class DashboardRouter: PresenterToRouterProtocol {
    
    static func createModule() -> DashboardVC {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
        
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = DashboardPresenter()
        let interactor: PresenterToInteractorProtocol = DashbaordInteractor()
        let router:PresenterToRouterProtocol = DashboardRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func pushToCheckoutScreen(menu: [MenuModel], navigationConroller: UINavigationController) {
        let checkoutModule = CheckoutRouter.createCheckoutModule()
        checkoutModule.arrCart = menu
        navigationConroller.isNavigationBarHidden = false
        navigationConroller.pushViewController(checkoutModule, animated: true)
    }
}
