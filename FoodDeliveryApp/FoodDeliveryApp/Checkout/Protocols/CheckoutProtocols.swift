//
//  CheckoutProtocols.swift
//  FoodDeliveryApp
//
//  Created by Dhruv Bhatt on 29/08/21.
//

import Foundation

import UIKit
import Foundation

protocol ViewToPresenterCheckoutProtocol: AnyObject {
    
    var view: PresenterToViewCheckoutProtocol? { get set }
    var interactor: PresenterToInteractorCheckoutProtocol? { get set }
    var router: PresenterToRouterCheckoutProtocol? { get set }

}

protocol PresenterToViewCheckoutProtocol: AnyObject {

}

protocol PresenterToRouterCheckoutProtocol: AnyObject {
    static func createCheckoutModule() -> CheckoutVC
}

protocol PresenterToInteractorCheckoutProtocol: AnyObject {
    var presenter: InteractorToPresenterCheckoutProtocol? { get set }
}

protocol InteractorToPresenterCheckoutProtocol: AnyObject {

}
