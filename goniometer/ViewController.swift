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
    
    var dotLayer = CAShapeLayer()
    var dotStartPosition = CGPoint(x: 100, y: 200)
    
    let beginDotLayer = CAShapeLayer()
    let middleDotLayer = CAShapeLayer()
    let endDotLayer = CAShapeLayer()
    
    var beginDotPosition = CGPoint(x: 100, y: 300)
    var middleDotPosition = CGPoint(x: 100, y: 200)
    var endDotPosition = CGPoint(x: 150, y: 200)
    
    var panStart = CGPoint(x: 0, y: 0)
    
    //MARK Actions
    @IBAction func handleDotPan(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began {
            panStart = gestureRecognizer.location(in: self.view)
            let beginDistance = hypot(beginDotLayer.position.x - panStart.x, beginDotLayer.position.y - panStart.y)
            let middleDistance = hypot(middleDotLayer.position.x - panStart.x, middleDotLayer.position.y - panStart.y)
            let endDistance = hypot(endDotLayer.position.x - panStart.x, endDotLayer.position.y - panStart.y)
            //   Set dotLayer to the nearest dot to move
            if beginDistance < middleDistance {
                if beginDistance < endDistance {
                    dotLayer = beginDotLayer
                } else {
                    dotLayer = endDotLayer
                }
            } else {
                if middleDistance < endDistance {
                    dotLayer = middleDotLayer
                } else {
                    dotLayer = endDotLayer
                }
            }
            
            dotStartPosition = dotLayer.position
        } else if gestureRecognizer.state == .changed {
            let translation = gestureRecognizer.translation(in: self.view)
            dotLayer.position = CGPoint(x: dotStartPosition.x + translation.x, y: dotStartPosition.y + translation.y)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        drawDots()
        
        view.isUserInteractionEnabled = true
        
    }
    
    func drawDots() {
        let beginDotPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 12, height: 12))
        
        beginDotLayer.path = beginDotPath.cgPath
        beginDotLayer.fillColor = UIColor.red.cgColor
        beginDotLayer.position = beginDotPosition

        let middleDotPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 12, height: 12))
        
        middleDotLayer.path = middleDotPath.cgPath
        middleDotLayer.fillColor = UIColor.green.cgColor
        middleDotLayer.position = middleDotPosition

        let endDotPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 12, height: 12))
        
        endDotLayer.path = endDotPath.cgPath
        endDotLayer.fillColor = UIColor.blue.cgColor
        endDotLayer.position = endDotPosition

        view.layer.addSublayer(beginDotLayer)
        view.layer.addSublayer(middleDotLayer)
        view.layer.addSublayer(endDotLayer)

    }
    
//    func createRectangle() {
//        // Initialize the path.
//        let path = UIBezierPath()
//
//        // Specify the point that the path should start get drawn.
//        path.move(to: CGPoint(x: 0.0, y: 0.0))
//
//        // Create a line between the starting point and the bottom-left side of the view.
//        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
//
//        // Create the bottom line (bottom-left to bottom-right).
//        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
//
//        // Create the vertical line from the bottom-right to the top-right side.
//        path.addLine(to: CGPoint(x: self.frame.size.width, y: 0.0))
//
//        // Close the path. This will create the last line automatically.
//        path.close()
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

}

