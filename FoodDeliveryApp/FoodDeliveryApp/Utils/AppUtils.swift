//
//  AppUtils.swift
//  FoodDeliveryApp
//
//  Created by Dhruv Bhatt on 29/08/21.
//

import UIKit
import Foundation

let PROGRESS_INDICATOR_VIEW_TAG: Int = 10

/* Show Progress Indicator */
func showProgressIndicator(view: UIView) {
    
    view.isUserInteractionEnabled = false
    
    // Create and add the view to the screen.
    let progressIndicator = ProgressIndicator(text: "Please wait..")
    progressIndicator.tag = PROGRESS_INDICATOR_VIEW_TAG
    view.addSubview(progressIndicator)
}

/* Hide progress Indicator */
func hideProgressIndicator(view: UIView) {
    view.isUserInteractionEnabled = true
    
    if let viewWithTag = view.viewWithTag(PROGRESS_INDICATOR_VIEW_TAG) {
        viewWithTag.removeFromSuperview()
    }
}
