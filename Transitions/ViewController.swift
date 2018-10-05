//
//  ViewController.swift
//  Transitions
//
//  Created by Madison Waters on 10/4/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate, LabelProviding {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.transitioningDelegate = self
    }

    let animator = Animator()
    
    @IBOutlet weak var colorlabel: UILabel!
    
}

