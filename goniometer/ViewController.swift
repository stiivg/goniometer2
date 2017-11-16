//
//  ViewController.swift
//  goniometer
//
//  Created by Steven Gallagher on 11/15/17.
//  Copyright © 2017 Steven Gallagher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var kneeImage: UIImageView!
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    
    let dotLayer = CAShapeLayer()

    //MARK Actions
    @IBAction func handleDotPan(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let translation = gestureRecognizer.translation(in: self.view)
            dotLayer.position = CGPoint(x: translation.x, y: translation.y)
           // note: 'view' is optional and need to be unwrapped
//            sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
//            sender.setTranslation(CGPoint.zero, in: self.view)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let dotPath = UIBezierPath(ovalIn: CGRect(x: 200, y: 300, width: 12, height: 12))
        
        dotLayer.path = dotPath.cgPath
        dotLayer.strokeColor = UIColor.red.cgColor
        
        view.layer.addSublayer(dotLayer)
        
        view.isUserInteractionEnabled = true
//        view.addGestureRecognizer(panGesture)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

}

