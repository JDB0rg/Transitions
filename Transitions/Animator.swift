//
//  Animator.swift
//  Transitions
//
//  Created by Madison Waters on 10/4/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

protocol LabelProviding {
    var colorlabel: UILabel! { get }
}

typealias LabelProvidingVC = LabelProviding & UIViewController

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // giving us info about the controllers and parts we'll use in the transition.
        guard let fromVC = transitionContext.viewController(forKey: .from) as? LabelProvidingVC,
        
            let toVC = transitionContext.viewController(forKey: .to) as? LabelProvidingVC,
            let toView = transitionContext.view(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
                                                    // Blue View Controller
        let toViewEndFrame = transitionContext.finalFrame(for: toVC)
        containerView.addSubview(toView)
        // setting this here but can change depending on animation
        toView.frame = toViewEndFrame
        toView.alpha = 0
        
        let fromLabel = fromVC.colorlabel!
        let toLabel = toVC.colorlabel!
        
        toLabel.alpha = 0
        fromLabel.alpha = 0
        
        let labelInitialFrame = containerView.convert(fromLabel.bounds, from: fromLabel)
        
        let animatedLabel = UILabel(frame: labelInitialFrame)

        animatedLabel.text = fromLabel.text
        animatedLabel.font = fromLabel.font
        
        containerView.addSubview(animatedLabel)
        
        let duration = transitionDuration(using: transitionContext)
        
        toView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, animations: {
            
            let labelEndFrame = containerView.convert(toLabel.bounds, from: toLabel)
            
            animatedLabel.frame = labelEndFrame
            
            toView.alpha = 1
            
        }) { (_) in
            
            // Reset Views original state
            toLabel.alpha = 1
            fromLabel.alpha = 1
            
            animatedLabel.removeFromSuperview()
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
    
}
