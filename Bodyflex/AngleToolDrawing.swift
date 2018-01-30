//
//  AngleToolDrawing.swift
//  Bodyflex
//
//  Created by Steven Gallagher on 1/22/18.
//  Copyright © 2018 Steven Gallagher. All rights reserved.
//

import UIKit

class AngleToolDrawing {

    //Default tool dimensions
    let dotDiameterDefault = CGFloat(20)
    let dotRadiusDefault = CGFloat(10)
    let dotLineWidthDefault = CGFloat(2)
    let lineWidthDefault = CGFloat(5)
    let extensionLengthDefault = CGFloat(60)
    let angleTextDistanceDefault = CGFloat(65)
    let arcRadiusDefault = CGFloat(40)
    let arcLineWidthDefault = CGFloat(1)
    
    let fontFrameSizeDefault = CGSize(width: 60, height: 20)
    let angleFontSizeDefault = CGFloat(16)

    //working tool dimensions
    var dotDiameter = CGFloat(20)
    var dotRadius = CGFloat(10)
    var dotLineWidth = CGFloat(2)
    var lineWidth = CGFloat(5)
    var extensionLength = CGFloat(60)
    var angleTextDistance = CGFloat(65)
    var arcRadius = CGFloat(40)
    var arcLineWidth = CGFloat(1)
    
    var fontFrameSize = CGSize(width: 60, height: 20)
    var angleFontSize = CGFloat(16)


    let beginDotLayer = CAShapeLayer()
    let middleDotLayer = CAShapeLayer()
    let endDotLayer = CAShapeLayer()
    let animationLayer = CAShapeLayer()
    let textLayer = CATextLayer()

    let beginLineMask = CAShapeLayer()
    let endLineMask = CAShapeLayer()


    let beginLineLayer = CAShapeLayer()
    let endLineLayer = CAShapeLayer()
    let arcLineLayer = CAShapeLayer()
    
    var animation = true

    var angleLabel = UILabel()

    var dotPositions = [CGPoint]()

    var measuredAngle = CGFloat(0.0)

    var imageView: UIImageView?

    var rotationCW = true
    var angleQuadrant = "Quadrant0"

    init() {
        initTextLayer()
    }

    func setImageView(imageView: UIImageView) {
        self.imageView = imageView
        
        //Add all the tool layers and the animation layer
        imageView.layer.addSublayer(arcLineLayer)
        imageView.layer.addSublayer(beginLineLayer)
        imageView.layer.addSublayer(endLineLayer)
        
        imageView.layer.addSublayer(beginDotLayer)
        imageView.layer.addSublayer(middleDotLayer)
        imageView.layer.addSublayer(endDotLayer)
        
        imageView.layer.addSublayer(textLayer)
        
        beginLineLayer.addSublayer(animationLayer) //Animation obeys the line mask to keep the dot clear
        
        //1000 magic number that makes the scale look good
//        scaleTool(scale: imageView.bounds.height / 1000)
//        scaleTool(scale: 628 / 1000)
    }


    func drawTool(dotPositions: [CGPoint]) {
        self.dotPositions = dotPositions
        scaleToLineLength()
        calcAngle()
        
        drawDots()
        drawLines()
        drawAngleArc()
        drawAngle()
        
        if animation {
            dotAnimation()
        }
    }

    
    fileprivate func scaleToLineLength() {
        let dX = dotPositions[1].x - dotPositions[0].x
        let dY = dotPositions[1].y - dotPositions[0].y
        let mainLength = hypot(dX, dY)

        var scale = 0.17 + mainLength / 350
        scale = max(scale, 0.3) //limit minimum scale
        scaleTool(scale: scale)
        
    }
    
    //Scale the angle tool
    func scaleTool(scale: CGFloat) {
        dotDiameter = dotDiameterDefault * scale
        dotRadius = dotRadiusDefault * scale
        dotLineWidth = dotLineWidthDefault * scale
        lineWidth = lineWidthDefault * scale
        extensionLength = extensionLengthDefault * scale
        angleTextDistance = angleTextDistanceDefault * scale
        arcRadius = arcRadiusDefault * scale
        arcLineWidth = arcLineWidthDefault * scale
        
        scaleTextLayer(scale: scale)
    }

    //Quadrant0 is main arm, Quadrant180 is main arm extended, angle is CW
    func setQuadrant(rotationCW: Bool, insideOutside: String) {
        var quadrant = "Quadrant0"
        if insideOutside == "Outside" {
            quadrant = "Quadrant180"
        }
        if insideOutside == "Outside-90" && rotationCW || insideOutside == "Inside-90" && !rotationCW {
            //extension 90 degree clockwise
            quadrant = "Quadrant270"
        } else if insideOutside == "Outside-90" && !rotationCW || insideOutside == "Inside-90" && rotationCW {
            //extension 90 degree counter clockwise
            quadrant = "Quadrant90"
        }
        angleQuadrant = quadrant
    }
    
    // MARK: - Utilities

    //Scale the pixel position to a location in the image view
    func convertPixelToLocation(position: CGPoint, origin: CGPoint, scale: CGFloat) -> CGPoint {
        var location = CGPoint()
        
        location.x = position.x * scale + origin.x
        location.y = position.y * scale + origin.y
        
        return location
    }
    
    //Scale the location in the image view to a pixel location
    func convertLocationToPixel(location: CGPoint, origin: CGPoint, scale: CGFloat) -> CGPoint {
        var pixelDotPosition = CGPoint()
        
        pixelDotPosition.x = (location.x - origin.x) / scale
        pixelDotPosition.y = (location.y - origin.y) / scale
        
        return pixelDotPosition
    }
    
    //image centered with either width or height the same
    func calculateImageTransform(imageView: UIImageView) -> (rect:CGRect, scale:CGFloat) {
        let imageViewSize = imageView.bounds.size
        let imgSize = imageView.image?.size
        
        guard let imageSize = imgSize, imgSize != nil else {
            return (CGRect.zero, CGFloat(1))
        }
        
        let scaleWidth = imageViewSize.width / imageSize.width
        let scaleHeight = imageViewSize.height / imageSize.height
        var aspect = fmin(scaleWidth, scaleHeight) // assume aspectFit
        if imageView.contentMode == .scaleAspectFill {
            aspect = fmax(scaleWidth, scaleHeight)
        }
        
        var imageRect = CGRect(x: 0, y: 0, width: imageSize.width * aspect, height: imageSize.height * aspect)
        // Center image
        imageRect.origin.x = (imageViewSize.width - imageRect.size.width) / 2
        imageRect.origin.y = (imageViewSize.height - imageRect.size.height) / 2
                
        return (imageRect, aspect)
    }

    fileprivate func drawDots() {
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
        beginClippingPath.append(endDotPath) //all three dots for animation layer added to the beginline
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

    fileprivate func dotAnimation() {
        //Common end size
        let endSize = CGSize(width: dotDiameter * 2.5, height: dotDiameter * 2.5)
        
        //  setup for begin dot animation
        let startOrigin = CGPoint(x: dotPositions[0].x - dotRadius, y: dotPositions[0].y - dotRadius)
        let startPath = UIBezierPath(ovalIn: CGRect(origin: startOrigin , size: CGSize(width: dotDiameter, height: dotDiameter)))
        let endOrigin = CGPoint(x:dotPositions[0].x - endSize.width / 2, y:dotPositions[0].y - endSize.height / 2)
        
        let endPath = UIBezierPath(ovalIn: CGRect(origin: endOrigin, size: endSize))
        
        //  setup for middle dot animation
        let startOrigin1 = CGPoint(x: dotPositions[1].x - dotRadius, y: dotPositions[1].y - dotRadius)
        let startPath1 = UIBezierPath(ovalIn: CGRect(origin: startOrigin1 , size: CGSize(width: dotDiameter, height: dotDiameter)))
        let endOrigin1 = CGPoint(x:dotPositions[1].x - endSize.width / 2, y:dotPositions[1].y - endSize.height / 2)
        
        let endPath1 = UIBezierPath(ovalIn: CGRect(origin: endOrigin1, size: endSize))
        
        //  setup for end dot animation
        let startOrigin2 = CGPoint(x: dotPositions[2].x - dotRadius, y: dotPositions[2].y - dotRadius)
        let startPath2 = UIBezierPath(ovalIn: CGRect(origin: startOrigin2 , size: CGSize(width: dotDiameter, height: dotDiameter)))
        let endOrigin2 = CGPoint(x:dotPositions[2].x - endSize.width / 2, y:dotPositions[2].y - endSize.height / 2)
        
        let endPath2 = UIBezierPath(ovalIn: CGRect(origin: endOrigin2, size: endSize))
        
        // Combine all three start and end paths
        startPath.append(startPath1)
        startPath.append(startPath2)
        endPath.append(endPath1)
        endPath.append(endPath2)
        
        //Main arm midline animation
        let majorLinePosition = linePosition(startPoint: dotPositions[0], endPoint: dotPositions[1])
        let mainOrigin = CGPoint(x: majorLinePosition.x - dotRadius, y: majorLinePosition.y - dotRadius)
        let mainStartPath = UIBezierPath(ovalIn: CGRect(origin: mainOrigin , size: CGSize(width: dotDiameter, height: dotDiameter)))
        let mainEndOrigin = CGPoint(x:majorLinePosition.x - endSize.width / 2, y:majorLinePosition.y - endSize.height / 2)
        let mainEndPath = UIBezierPath(ovalIn: CGRect(origin: mainEndOrigin, size: endSize))
        
        startPath.append(mainStartPath)
        endPath.append(mainEndPath)
        
        //Minor arm midline animation
        let minorLinePosition = linePosition(startPoint: dotPositions[1], endPoint: dotPositions[2])
        let minorOrigin = CGPoint(x: minorLinePosition.x - dotRadius, y: minorLinePosition.y - dotRadius)
        let minorStartPath = UIBezierPath(ovalIn: CGRect(origin: minorOrigin , size: CGSize(width: dotDiameter, height: dotDiameter)))
        let minorEndOrigin = CGPoint(x:minorLinePosition.x - endSize.width / 2, y:minorLinePosition.y - endSize.height / 2)
        let minorEndPath = UIBezierPath(ovalIn: CGRect(origin: minorEndOrigin, size: endSize))
        
        startPath.append(minorStartPath)
        endPath.append(minorEndPath)
        
        // Create the path animation
        let animation = CABasicAnimation(keyPath: "path")
        
        animation.fromValue = startPath.cgPath
        animation.toValue = endPath.cgPath
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut) // animation curve is Ease Out
        animation.fillMode = kCAFillModeBoth // keep to value after finishing
        animation.isRemovedOnCompletion = false // don't remove after finishing
        //        animation.autoreverses = true
        animation.repeatCount = HUGE // repeat forever
        
        // Create the fade animation
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.fromValue = 0.4
        fadeAnimation.toValue = 0.0
        
        // Group the path and fade animations
        let group = CAAnimationGroup()
        group.isRemovedOnCompletion = false // don't remove after finishing
        group.repeatCount = HUGE
        group.animations = [animation, fadeAnimation]
        group.duration = 2
        
        animationLayer.add(group, forKey: "path")
        animationLayer.fillColor = UIColor.white.cgColor
    }

    fileprivate func drawLines() {
        let beginPath = UIBezierPath()
        beginPath.move(to: dotPositions[0])
        beginPath.addLine(to: dotPositions[1])
 
        //calculate extended end point
        let dX = dotPositions[1].x - dotPositions[0].x
        let dY = dotPositions[1].y - dotPositions[0].y
        let length = hypot(dX, dY)
        let ratio = extensionLength / length
        //Assume Quadrant0 no extension
        var extensionX = CGFloat(0)
        var extensionY = CGFloat(0)

        switch angleQuadrant {
        case "Quadrant90":
            //extension 90 degree clockwise
            extensionX = ratio * dY
            extensionY = -ratio * dX
        case "Quadrant270":
            //extension 90 degree counter clockwise
            extensionX = -ratio * dY
            extensionY = ratio * dX
        case "Quadrant180":
            extensionX = ratio * dX
            extensionY = ratio * dY
        default:
            extensionX = 0
            extensionY = 0
        }
        let extensionEndPosition = CGPoint(x: dotPositions[1].x + extensionX, y: dotPositions[1].y + extensionY)
        beginPath.addLine(to: extensionEndPosition)
        
        beginLineLayer.mask = beginLineMask
        beginLineLayer.path = beginPath.cgPath
        beginLineLayer.lineWidth = lineWidth
        beginLineLayer.strokeColor = UIColor.magenta.cgColor
        beginLineLayer.fillColor = UIColor.clear.cgColor //Prevent auto closing of path and filling with black
        beginLineLayer.lineCap = kCALineJoinRound
        
        let endPath = UIBezierPath()
        endPath.move(to: dotPositions[1])
        endPath.addLine(to: dotPositions[2])
        
        endLineLayer.mask = endLineMask
        endLineLayer.path = endPath.cgPath
        endLineLayer.lineWidth = lineWidth
        endLineLayer.strokeColor = UIColor.cyan.cgColor
    }

    func initTextLayer() {
        let fontName: CFString = "HelveticaNeue" as CFString
        textLayer.font = CTFontCreateWithName(fontName, 8, nil)
        textLayer.opacity = 0.6
        
        textLayer.foregroundColor = UIColor.black.cgColor
        textLayer.backgroundColor = UIColor.white.cgColor
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.contentsScale = UIScreen.main.scale
        
        scaleTextLayer(scale: 1.0)
    }

    fileprivate func scaleTextLayer(scale: CGFloat) {
        fontFrameSize = CGSize(width: fontFrameSizeDefault.width * scale, height: fontFrameSizeDefault.height * scale)
        angleFontSize = angleFontSizeDefault * scale
        
        textLayer.frame.size = fontFrameSize
        textLayer.fontSize = angleFontSize
    }

    fileprivate func drawAngleArc() {
        let arcLineOrigin = CGPoint(x: dotPositions[1].x, y: dotPositions[1].y)
        var clockwise = rotationCW
        if measuredAngle < 0 {
            clockwise = !clockwise
        }
        
        var startAngle = mainArmAngle()
        let endAngle = minorArmAngle()
        
        switch angleQuadrant {
        case "Quadrant0":
            //zero is down main arm
            if startAngle < CGFloat.pi {
                startAngle = startAngle + CGFloat.pi
            } else {
                startAngle = startAngle - CGFloat.pi
            }
        case "Quadrant90":
            //90 CW from main arm
            if startAngle > CGFloat.pi / 2 {
                startAngle = startAngle -  CGFloat.pi / 2
            } else {
                startAngle = startAngle +  CGFloat.pi * 3 / 2
            }
        case "Quadrant270":
            if startAngle > CGFloat.pi * 3 / 2 {
                startAngle = startAngle - CGFloat.pi * 3 / 2
            } else {
                startAngle = startAngle + CGFloat.pi / 2
            }
        default: break
        }

        let arcLinePath = UIBezierPath.init(arcCenter: arcLineOrigin, radius: arcRadius, startAngle: startAngle, endAngle: endAngle , clockwise: clockwise)
        
        
        arcLineLayer.path = arcLinePath.cgPath
        arcLineLayer.lineWidth = arcLineWidth
        arcLineLayer.strokeColor = UIColor.black.cgColor
        arcLineLayer.fillColor = UIColor.clear.cgColor
        
    }

    fileprivate func drawAngle() {
        let angleText = String(format: "%.1f", measuredAngle) + "\u{00B0}"
        
        textLayer.string = angleText
        textLayer.position = textPoint()
    }

    //    fileprivate func drawTextFill(textOrigin: CGPoint) {
    //        let fillWidth = textLayer.frame.width
    //        let fillHeight = textLayer.frame.height
    //        let rect = CGRect(x: textOrigin.x - fillWidth / 2, y: textOrigin.y - fillHeight / 2, width: fillWidth, height: fillHeight)
    //        let textFillPath = UIBezierPath(roundedRect: rect, cornerRadius: CGFloat(3))
    //
    //        textFillLayer.path = textFillPath.cgPath
    //        textFillLayer.strokeColor = UIColor.clear.cgColor
    //        textFillLayer.fillColor = UIColor.white.cgColor
    //        textFillLayer.opacity = 0.6
    //    }

    fileprivate func textPoint() -> CGPoint {
        let measuredAngleRadians = measuredAngle / 2 * CGFloat(CGFloat.pi / 180)
        var textAngle =  mainArmAngle() - measuredAngleRadians
        if rotationCW {
            textAngle =  mainArmAngle() + measuredAngleRadians
        }
        //Adjust for which quadrant is zero
        switch angleQuadrant {
        case "Quadrant0":
            //zero is down main arm
            textAngle = textAngle + CGFloat.pi
        case "Quadrant90":
            textAngle = textAngle - CGFloat.pi / 2
        case "Quadrant270":
            textAngle = textAngle + CGFloat.pi / 2
        default: break
        }
        let textOffset = CGPoint(x: angleTextDistance * cos(textAngle), y: angleTextDistance * sin(textAngle))
        let textPoint = CGPoint(x: dotPositions[1].x + textOffset.x, y: dotPositions[1].y + textOffset.y)
        
        return textPoint
    }

    //use difference of main arm angle and minor arm angle +/-180 degrees
    fileprivate func calcAngle() {
        let diff = (mainArmAngle() - minorArmAngle()) * CGFloat(180 / CGFloat.pi) //convert radians to degrees
        let absDiff = abs(diff)
        measuredAngle = diff
        //Reduce angles over 180
        if absDiff > 180{
            measuredAngle = 360 - absDiff
            if diff > 0 { //change sign if original large angle was positive
                measuredAngle = -measuredAngle
            }
        }
        //Adjust for which quadrant is zero
        switch angleQuadrant {
        case "Quadrant0":
            //zero is down main arm
            let insideAngle = 180 - abs(measuredAngle)
            if measuredAngle > 0 {
                measuredAngle = -insideAngle
            } else {
                measuredAngle = insideAngle
            }
        case "Quadrant90":
            let insideAngle = measuredAngle - 90
            if measuredAngle < -90 {
                measuredAngle = insideAngle + 360
            } else {
                measuredAngle = insideAngle
            }
        case "Quadrant270":
            //90 CW from main arm
            let insideAngle = measuredAngle + 90
            if measuredAngle > 90 {
                measuredAngle = insideAngle - 360
            } else {
                measuredAngle = insideAngle
            }
        default: break
        }
        //Angle default is CCW so change sign if CW is required
        if rotationCW {
            measuredAngle = -measuredAngle
        }

    }
    //TODO make this the Q0 angle and correct all usage
    //Angle to the Q180 extension!
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
    

    //Calculate the midpoint of the line
     fileprivate func linePosition(startPoint: CGPoint, endPoint: CGPoint) -> CGPoint {
        let linePosition = CGPoint(x: startPoint.x + (endPoint.x - startPoint.x) / 2, y: startPoint.y + (endPoint.y - startPoint.y) / 2)
        return linePosition
    }
}

