//
//  AngleTool.swift
//  goniometer
//
//  Created by Steven Gallagher on 12/7/17.
//  Copyright © 2017 Steven Gallagher. All rights reserved.
//


import UIKit

class AngleTool {
    
    var beginDotPosition = CGPoint(x: 100, y: 300)
    var middleDotPosition = CGPoint(x: 100, y: 200)
    var endDotPosition = CGPoint(x: 150, y: 200)
    var dotPositions = [CGPoint]()
    var movingDotIndex = 1

    var panStart = CGPoint(x: 0, y: 0)

    var measuredAngle = CGFloat(0.0)

    var dotLayer = CAShapeLayer()
    var dotStartPosition = CGPoint(x: 100, y: 200)

    let beginDotLayer = CAShapeLayer()
    let middleDotLayer = CAShapeLayer()
    let endDotLayer = CAShapeLayer()

    let beginLineLayer = CAShapeLayer()
    let endLineLayer = CAShapeLayer()
    
    var angleLabel = UILabel()

    init() {
        
        dotPositions = [beginDotPosition, middleDotPosition, endDotPosition]
        
        drawTool()

    }
    
    func addToolLayers(imageView: UIView) {
        imageView.layer.addSublayer(beginLineLayer)
        imageView.layer.addSublayer(endLineLayer)
        
        
        imageView.layer.addSublayer(beginDotLayer)
        imageView.layer.addSublayer(middleDotLayer)
        imageView.layer.addSublayer(endDotLayer)

    }
    
    func doHandleDotPan(gestureRecognizer: UIPanGestureRecognizer, view: UIView) {
        if gestureRecognizer.state == .began {
            panStart = gestureRecognizer.location(in: view)
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
            let translation = gestureRecognizer.translation(in: view)
            dotPositions[movingDotIndex] = CGPoint(x: dotStartPosition.x + translation.x, y: dotStartPosition.y + translation.y)
            
            drawTool()
        }
    }
    
    func drawTool() {
        drawDots()
        drawLines()
        drawAngle()
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
        calcAngle()
        angleLabel.text = String(format: "%.1f", measuredAngle) + "\u{00B0}"
    }
    

    func calcAngle() {
        let distance01 = hypot(dotPositions[0].x - dotPositions[1].x, dotPositions[0].y - dotPositions[1].y)
        let distance12 = hypot(dotPositions[1].x - dotPositions[2].x, dotPositions[1].y - dotPositions[2].y)
        let distance02 = hypot(dotPositions[0].x - dotPositions[2].x, dotPositions[0].y - dotPositions[2].y)
        
        let cosAngleNumerator = pow(distance01, 2) +  pow(distance12, 2)  - pow(distance02, 2)
        let cosAngleDenominator = 2 * distance01 * distance12
        let cosAngle = cosAngleNumerator / cosAngleDenominator
        let angleRadians = acos(cosAngle)
        measuredAngle = 180 - (angleRadians * CGFloat(180 / CGFloat.pi));
    }
}
