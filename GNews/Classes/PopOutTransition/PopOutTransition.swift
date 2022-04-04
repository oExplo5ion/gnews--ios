//
//  PopOutTransition.swift
//  GNews
//
//  Created by Aleksey on 02.04.2022.
//

import Foundation
import UIKit

fileprivate enum Defaults {
    static let transitionDuration = TimeInterval(0)
}

enum PopOutTransitionType {
    case present
    case dismiss
}

class PopOutTransition: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    let type: PopOutTransitionType
    
    init(type: PopOutTransitionType) {
        self.type = type
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Defaults.transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) else {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            return
        }
        guard let toVC = transitionContext.viewController(forKey: .to) else {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            return
        }
        guard let snapshot = fromVC.view.snapshotView(afterScreenUpdates: true) else {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            return
        }
        
        let containerView = transitionContext.containerView
        snapshot.frame = containerView.frame
        toVC.view.frame = containerView.frame
        
        switch type {
        case .present:
            containerView.addSubview(snapshot)
            containerView.addSubview(toVC.view)
            if let toVCAnim = toVC as? PopOutAnimatable {
                self.present(animatable: toVCAnim, context: transitionContext)
                return
            }
        case .dismiss:
            containerView.insertSubview(fromVC.view, belowSubview: toVC.view)
            if let fromVCAnim = fromVC as? PopOutAnimatable {
                self.dismiss(animatable: fromVCAnim, context: transitionContext)
                return
            }
        }
        
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
    
    private func present(animatable: PopOutAnimatable, context: UIViewControllerContextTransitioning) {
        animatable.popOutPresent {
            context.completeTransition(!context.transitionWasCancelled)
        }
    }
    
    private func dismiss(animatable: PopOutAnimatable, context: UIViewControllerContextTransitioning) {
        animatable.popOutDismiss {
            context.completeTransition(!context.transitionWasCancelled)
        }
    }
    
}
