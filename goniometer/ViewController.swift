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
    
    let beginLineLayer = CAShapeLayer()
    let endLineLayer = CAShapeLayer()

    let textLayer = CATextLayer()

    var beginDotPosition = CGPoint(x: 100, y: 300)
    var middleDotPosition = CGPoint(x: 100, y: 200)
    var endDotPosition = CGPoint(x: 150, y: 200)
    var dotPositions = [CGPoint]()
    var movingDotIndex = 1
    
    var panStart = CGPoint(x: 0, y: 0)
    
    //MARK Actions
    @IBAction func handleDotPan(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began {
            panStart = gestureRecognizer.location(in: self.view)
            let beginDistance = hypot(dotPositions[0].x - panStart.x, dotPositions[0].y - panStart.y)
            let middleDistance = hypot(dotPositions[1].x - panStart.x, dotPositions[1].y - panStart.y)
            let endDistance = hypot(dotPositions[2].x - panStart.x, dotPositions[2].y - panStart.y)
            
            //   Set movingDotIndex to the nearest dot to move
            let nearestDot = min(min(beginDistance, middleDistance), endDistance)
            switch nearestDot {
            case beginDistance:
                movingDotIndex = 0
            case middleDistance:
                movingDotIndex = 1
            case endDistance:
                movingDotIndex = 2
            default:
                movingDotIndex = 0
            }

            dotStartPosition = dotPositions[movingDotIndex]
        } else if gestureRecognizer.state == .changed {
            let translation = gestureRecognizer.translation(in: self.view)
            dotPositions[movingDotIndex] = CGPoint(x: dotStartPosition.x + translation.x, y: dotStartPosition.y + translation.y)
            
            drawDots()
            drawLines()
            drawAngle()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dotPositions = [beginDotPosition, middleDotPosition, endDotPosition]
        
        drawDots()
        drawLines()
        drawAngle()
        
        view.layer.addSublayer(beginLineLayer)
        view.layer.addSublayer(endLineLayer)

 
        view.layer.addSublayer(beginDotLayer)
        view.layer.addSublayer(middleDotLayer)
        view.layer.addSublayer(endDotLayer)
        view.isUserInteractionEnabled = true
  
        view.layer.addSublayer(textLayer)

    }
    
    func drawDots() {
        let beginOrigin = CGPoint(x: dotPositions[0].x - 6, y: dotPositions[0].y - 6)
        let beginDotPath = UIBezierPath(ovalIn: CGRect(origin: beginOrigin, size: CGSize(width: 12, height: 12)))
        
        beginDotLayer.path = beginDotPath.cgPath
        beginDotLayer.fillColor = UIColor.red.cgColor

        let middleOrigin = CGPoint(x: dotPositions[1].x - 6, y: dotPositions[1].y - 6)
        let middleDotPath = UIBezierPath(ovalIn: CGRect(origin: middleOrigin, size: CGSize(width: 12, height: 12)))

        middleDotLayer.path = middleDotPath.cgPath
        middleDotLayer.fillColor = UIColor.green.cgColor

        let endOrigin = CGPoint(x: dotPositions[2].x - 6, y: dotPositions[2].y - 6)
        let endDotPath = UIBezierPath(ovalIn: CGRect(origin: endOrigin, size: CGSize(width: 12, height: 12)))

        endDotLayer.path = endDotPath.cgPath
        endDotLayer.fillColor = UIColor.blue.cgColor

    }
    
    func drawLines() {
        let beginPath = UIBezierPath()
        beginPath.move(to: dotPositions[0])
        beginPath.addLine(to: dotPositions[1])
        
        beginLineLayer.path = beginPath.cgPath
        beginLineLayer.lineWidth = 2.0
        //        beginLineLayer.fillColor = nil
        //        beginLineLayer.opacity = 1.0
        beginLineLayer.strokeColor = UIColor.cyan.cgColor
        
        let endPath = UIBezierPath()
        endPath.move(to: dotPositions[1])
        endPath.addLine(to: dotPositions[2])
        
        endLineLayer.path = endPath.cgPath
        endLineLayer.lineWidth = 2.0
        //        endLineLayer.fillColor = nil
        //        endLineLayer.opacity = 1.0
        endLineLayer.strokeColor = UIColor.cyan.cgColor
        
    }
    func drawAngle() {
        textLayer.frame = CGRect(x: 10, y: 80, width: view.bounds.width, height: 50)
        let string = String(152)
        
        textLayer.string = string
        
        let fontName: CFString = "HelveticaNeue" as CFString
        textLayer.font = CTFontCreateWithName(fontName, 16, nil)
        
        textLayer.foregroundColor = UIColor.darkGray.cgColor
        textLayer.isWrapped = true
        textLayer.alignmentMode = kCAAlignmentLeft
        textLayer.contentsScale = UIScreen.main.scale

    }
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

}

