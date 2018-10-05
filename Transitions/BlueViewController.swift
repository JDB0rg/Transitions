//
//  BlueViewController.swift
//  Transitions
//
//  Created by Madison Waters on 10/4/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

class BlueViewController: UIViewController, UIViewControllerTransitioningDelegate, LabelProviding {

    
    @IBOutlet weak var colorlabel: UILabel!
    
    @IBAction func dismiss(_ sender: Any) {
        
        transitioningDelegate = self
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return interactionController
    }
    
    let animator = Animator()
    
    private var interactionController: UIPercentDrivenInteractiveTransition?

    @IBAction func pan(_ sender: UIPanGestureRecognizer) {
        
        switch sender.state {
            
        case .began:
            
            interactionController = UIPercentDrivenInteractiveTransition()
            dismiss(sender)
            
        case .changed:
            
            let translation = sender.translation(in: view)
            
            let percentageComplete = abs(translation.y / view.bounds.height)
            
            interactionController?.update(percentageComplete)
            
            
            
        case .ended:
            
            let velocity = sender.velocity(in: view)
            
            if velocity.y > 100 {
                interactionController?.finish()
            } else {
                interactionController?.cancel()
            }
            
            interactionController = nil
            
        default:
            break
        }
        
    }
}
