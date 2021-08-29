//
//  CheckoutPresenter.swift
//  FoodDeliveryApp
//
//  Created by Dhruv Bhatt on 29/08/21.
//

import Foundation

class CheckoutPresenter: ViewToPresenterCheckoutProtocol {
    
    var view: PresenterToViewCheckoutProtocol?
    var interactor: PresenterToInteractorCheckoutProtocol?
    var router: PresenterToRouterCheckoutProtocol?

}

extension CheckoutPresenter: InteractorToPresenterCheckoutProtocol {

}
