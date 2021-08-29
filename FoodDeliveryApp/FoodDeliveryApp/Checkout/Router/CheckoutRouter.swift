//
//  CheckoutRouter.swift
//  FoodDeliveryApp
//
//  Created by Dhruv Bhatt on 29/08/21.
//

import UIKit
import Foundation

class CheckoutRouter: PresenterToRouterCheckoutProtocol {
 
    static func createCheckoutModule() -> CheckoutVC {
        
        let view = CheckoutRouter.mainstoryboard.instantiateViewController(withIdentifier: "CheckoutVC") as! CheckoutVC
        
        let presenter: ViewToPresenterCheckoutProtocol & InteractorToPresenterCheckoutProtocol = CheckoutPresenter()
        let interactor: PresenterToInteractorCheckoutProtocol = CheckoutInteractor()
        let router: PresenterToRouterCheckoutProtocol = CheckoutRouter()
        
        view.checkoutPresenter = presenter
        presenter.view = view as? PresenterToViewCheckoutProtocol
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
