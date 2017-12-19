//
//  AngleTool.swift
//  goniometer
//
//  Created by Steven Gallagher on 12/7/17.
//  Copyright © 2017 Steven Gallagher. All rights reserved.
//


import UIKit
import CoreData

class AngleTool {
    
    var imageView: UIView?

    var measurement: NSManagedObject?
    
    var beginDotPosition = CGPoint(x: 100, y: 300)
    var middleDotPosition = CGPoint(x: 100, y: 200)
    var endDotPosition = CGPoint(x: 150, y: 200)
    var dotPositions = [CGPoint]()
    var movingDotIndex = 1

    var panStart = CGPoint(x: 0, y: 0)

    var measuredAngle = CGFloat(0.0)

    var dotLayer = CAShapeLayer()
    var dotStartPosition = CGPoint(x: 100, y: 200)

    let dotDiameter = CGFloat(20)
    let dotRadius = CGFloat(10)
    let dotLineWidth = CGFloat(2)
    let lineWidth = CGFloat(5)
    let ExtensionLength = CGFloat(60)
    let angleTextDistance = CGFloat(60)
    let arcRadius = CGFloat(40)
    let arcLineWidth = CGFloat(1)
    
    let beginDotLayer = CAShapeLayer()
    let middleDotLayer = CAShapeLayer()
    let endDotLayer = CAShapeLayer()
    let textLayer = CATextLayer()
    
    let beginLineMask = CAShapeLayer()
    let endLineMask = CAShapeLayer()


    let beginLineLayer = CAShapeLayer()
    let endLineLayer = CAShapeLayer()
    let arcLineLayer = CAShapeLayer()
    
    var angleLabel = UILabel()

    init() {
        
        dotPositions = [beginDotPosition, middleDotPosition, endDotPosition]
        initTextLayer()
        
    }
    
    func setMeasurementObj(measurementObj: NSManagedObject) {
        measurement = measurementObj
    }

    //Restore dot positions from core data or use default
    func restoreLocation() {
//        if dataObj != nil {
        let fullResEntity = measurement?.value(forKey: "fullRes") as? NSManagedObject
        if fullResEntity != nil {
            dotPositions[0].x = measurement?.value(forKeyPath: "beginX") as! CGFloat
            dotPositions[0].y = measurement?.value(forKeyPath: "beginY") as! CGFloat
            
            dotPositions[1].x = measurement?.value(forKeyPath: "middleX") as! CGFloat
            dotPositions[1].y = measurement?.value(forKeyPath: "middleY") as! CGFloat
            
            dotPositions[2].x = measurement?.value(forKeyPath: "endX") as! CGFloat
            dotPositions[2].y = measurement?.value(forKeyPath: "endY") as! CGFloat
        } else {
            dotPositions[1] = (imageView?.center)!
            dotPositions[0] = dotPositions[1]
            dotPositions[0].y += (imageView?.frame.height)!/10

            dotPositions[2] = dotPositions[1]
            dotPositions[2].x += (imageView?.frame.width)!/10
        }
    }
    
    //Save dot positions to core data
    func saveLocation() {
        measurement?.setValue(dotPositions[0].x, forKey: "beginX")
        measurement?.setValue(dotPositions[0].y, forKey: "beginY")
        
        measurement?.setValue(dotPositions[1].x, forKey: "middleX")
        measurement?.setValue(dotPositions[1].y, forKey: "middleY")
        
        measurement?.setValue(dotPositions[2].x, forKey: "endX")
        measurement?.setValue(dotPositions[2].y, forKey: "endY")
    }
    
    func setImageView(imageView: UIView) {
        self.imageView = imageView
        imageView.layer.addSublayer(arcLineLayer)
        imageView.layer.addSublayer(beginLineLayer)
        imageView.layer.addSublayer(endLineLayer)
        
        
        imageView.layer.addSublayer(beginDotLayer)
        imageView.layer.addSublayer(middleDotLayer)
        imageView.layer.addSublayer(endDotLayer)
        
        imageView.layer.addSublayer(textLayer)
        
        restoreLocation()

        drawTool()

    }
    
    func pointInTool(inside point: CGPoint) -> Bool {
        for position in dotPositions {
            let distance = hypot(position.x - point.x, position.y - point.y)
            if distance < 30 {
                return true
            }
        }
        return false
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
        calcAngle()

        drawDots()
        drawLines()
        drawAngleArc()
        drawAngle()
    }

    
    func drawDots() {
        let beginOrigin = CGPoint(x: dotPositions[0].x - dotRadius, y: dotPositions[0].y - dotRadius)
        let beginDotPath = UIBezierPath(ovalIn: CGRect(origin: beginOrigin, size: CGSize(width: dotDiameter, height: dotDiameter)))

        let middleOrigin = CGPoint(x: dotPositions[1].x - dotRadius, y: dotPositions[1].y - dotRadius)
        let middleDotPath = UIBezierPath(ovalIn: CGRect(origin: middleOrigin, size: CGSize(width: dotDiameter, height: dotDiameter)))
        
        let endOrigin = CGPoint(x: dotPositions[2].x - dotRadius, y: dotPositions[2].y - dotRadius)
        let endDotPath = UIBezierPath(ovalIn: CGRect(origin: endOrigin, size: CGSize(width: dotDiameter, height: dotDiameter)))
        
        beginDotLayer.path = beginDotPath.cgPath
        beginDotLayer.lineWidth = dotLineWidth
        beginDotLayer.strokeColor = UIColor.magenta.cgColor
        beginDotLayer.fillColor = UIColor.clear.cgColor

        let beginClippingPath = beginDotPath
        beginClippingPath.append(middleDotPath)
        //invert the clipping path
        beginClippingPath.append(UIBezierPath(rect: (imageView?.bounds)!))
        beginLineMask.fillRule = kCAFillRuleEvenOdd
        
        beginLineMask.path = beginClippingPath.cgPath

        middleDotLayer.path = middleDotPath.cgPath
        middleDotLayer.lineWidth = dotLineWidth
        middleDotLayer.strokeColor = UIColor.magenta.cgColor
        middleDotLayer.fillColor = UIColor.clear.cgColor
        
        endDotLayer.path = endDotPath.cgPath
        endDotLayer.lineWidth = dotLineWidth
        endDotLayer.strokeColor = UIColor.cyan.cgColor
        endDotLayer.fillColor = UIColor.clear.cgColor

        let endClippingPath = endDotPath
        endClippingPath.append(middleDotPath)
       //invert the clipping path
        endClippingPath.append(UIBezierPath(rect: (imageView?.bounds)!))
        endLineMask.fillRule = kCAFillRuleEvenOdd
        
        endLineMask.path = endClippingPath.cgPath
}

    func drawLines() {
        let beginPath = UIBezierPath()
        beginPath.move(to: dotPositions[0])
        
        //calculate extended end point
        let dX = dotPositions[1].x - dotPositions[0].x
        let dY = dotPositions[1].y - dotPositions[0].y
        let length = hypot(dX, dY)
        let ratio = ExtensionLength / length

        let extensionEndPosition = CGPoint(x: dotPositions[1].x + ratio * dX, y: dotPositions[1].y + ratio * dY)
        
        beginPath.addLine(to: extensionEndPosition)
        
        beginLineLayer.mask = beginLineMask
        beginLineLayer.path = beginPath.cgPath
        beginLineLayer.lineWidth = lineWidth
        beginLineLayer.strokeColor = UIColor.magenta.cgColor
        beginLineLayer.lineCap = kCALineJoinRound

        let endPath = UIBezierPath()
        endPath.move(to: dotPositions[1])
        endPath.addLine(to: dotPositions[2])

        
        endLineLayer.mask = endLineMask
        endLineLayer.path = endPath.cgPath
        endLineLayer.lineWidth = lineWidth
        endLineLayer.strokeColor = UIColor.cyan.cgColor
        
    }

    fileprivate func initTextLayer() {
        let fontName: CFString = "HelveticaNeue" as CFString
        textLayer.frame.size = CGSize(width: 80, height: 30)
        textLayer.font = CTFontCreateWithName(fontName, 8, nil)
        textLayer.fontSize = 24
        textLayer.borderColor = UIColor.black.cgColor
        textLayer.borderWidth = 2.0
//        textLayer.isOpaque = true
        textLayer.opacity = 0.4
        //        textLayer.anchorPoint = CGPoint(x: 1, y: 1)
        
        textLayer.foregroundColor = UIColor.darkGray.cgColor
        textLayer.backgroundColor = UIColor.white.cgColor
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.contentsScale = UIScreen.main.scale
    }
    
    fileprivate func drawAngleArc() {
        let arcLineOrigin = CGPoint(x: dotPositions[1].x, y: dotPositions[1].y)
        var clockwise = true
        if measuredAngle > 0 {
            clockwise = false
        }
        let arcLinePath = UIBezierPath.init(arcCenter: arcLineOrigin, radius: arcRadius, startAngle: mainArmAngle(), endAngle: minorArmAngle() , clockwise: clockwise)
        
        arcLineLayer.path = arcLinePath.cgPath
        arcLineLayer.lineWidth = arcLineWidth
        arcLineLayer.strokeColor = UIColor.black.cgColor
        arcLineLayer.fillColor = UIColor.clear.cgColor
        
    }
    
    fileprivate func drawAngle() {
        let angleText = String(format: "%.1f", measuredAngle) + "\u{00B0}"
        let textCenter = CGPoint(x: 40, y: 15)
        var textOrigin = textPoint()
        textOrigin.x -= textCenter.x
        textOrigin.y -= textCenter.y


        textLayer.string = angleText
        textLayer.frame.origin = textOrigin

      
    }
    fileprivate func textPoint() -> CGPoint {
        let textAngle =  mainArmAngle() // + measuredAngle / 2 * CGFloat(CGFloat.pi / 180)
        let textOffset = CGPoint(x: angleTextDistance * cos(textAngle), y: angleTextDistance * sin(textAngle))
        let textPoint = CGPoint(x: dotPositions[1].x + textOffset.x, y: dotPositions[1].y + textOffset.y)
        
        return textPoint
    }
    
    //use difference of main arm angle and minor arm angle
    fileprivate func calcAngle() {
        let diff = (mainArmAngle() - minorArmAngle()) * CGFloat(180 / CGFloat.pi)
        let absDiff = abs(diff)
        measuredAngle = diff
        //Reduce angles over 180
        if absDiff > 180{
            measuredAngle = 360 - absDiff
            if diff > 0 { //change sign if original large angle was positive
                measuredAngle = -measuredAngle
            }
        }
    }
    
    //Right is zero, positive is clockwise 0 to 2xPI
    fileprivate func mainArmAngle() -> CGFloat {
        let dX = dotPositions[1].x - dotPositions[0].x
        let dY = dotPositions[1].y - dotPositions[0].y
        var mainArmAngle = atan(dY / dX)
        if dX < 0 {
            mainArmAngle = CGFloat.pi + mainArmAngle
        } else if dY < 0 {
            mainArmAngle = 2 * CGFloat.pi + mainArmAngle
        }
//        print("Main= " + String(format: "%.1f", mainArmAngle))
        return mainArmAngle
    }
    
    //Right is zero, positive is clockwise 0 to 2xPI
    fileprivate func minorArmAngle() -> CGFloat {
        let dX = dotPositions[2].x - dotPositions[1].x
        let dY = dotPositions[2].y - dotPositions[1].y
        var minorArmAngle = atan(dY / dX)
        if dX < 0 {
            minorArmAngle = CGFloat.pi + minorArmAngle
        } else if dY < 0 {
            minorArmAngle = 2 * CGFloat.pi + minorArmAngle
        }
//        print("Minor= " + String(format: "%.1f", minorArmAngle))
        return minorArmAngle
    }
    

//    //Using lengths of sides then cosine rule: b^2 = a^2 + c^2 - 2acCosB
//    func calcAngle() {
//        let distance01 = hypot(dotPositions[0].x - dotPositions[1].x, dotPositions[0].y - dotPositions[1].y)
//        let distance12 = hypot(dotPositions[1].x - dotPositions[2].x, dotPositions[1].y - dotPositions[2].y)
//        let distance02 = hypot(dotPositions[0].x - dotPositions[2].x, dotPositions[0].y - dotPositions[2].y)
//
//        let cosRuleNumerator = pow(distance01, 2) +  pow(distance12, 2)  - pow(distance02, 2)
//        let cosRuleDenominator = 2 * distance01 * distance12
//        let cosAngle = cosRuleNumerator / cosRuleDenominator
//        let angleRadians = acos(cosAngle)
//        measuredAngle = 180 - (angleRadians * CGFloat(180 / CGFloat.pi));
//    }
}
