//
//  DatePickerViewController+Transition.swift
//  GNews
//
//  Created by Aleksey on 04.04.2022.
//

import Foundation
import UIKit

extension DatePickerViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopOutTransition(type: .present)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopOutTransition(type: .dismiss)
    }
    
}
