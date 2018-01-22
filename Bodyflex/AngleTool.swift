//
//  AngleTool.swift
//  bodyflex
//
//  Created by Steven Gallagher on 12/7/17.
//  Copyright © 2017 Steven Gallagher. All rights reserved.
//


import UIKit
import CoreData

class AngleTool {
    

    var measurement: Measurement?
    
    var beginDotPosition = CGPoint(x: 100, y: 300)
    var middleDotPosition = CGPoint(x: 100, y: 200)
    var endDotPosition = CGPoint(x: 150, y: 200)
    var dotPositions = [CGPoint]()
    var movingDotIndex = 1

    var panStart = CGPoint(x: 0, y: 0)

    var dotStartPosition = CGPoint()
    var panBeginStartPosition = CGPoint()
    var panMiddleStartPosition = CGPoint()
    var panEndStartPosition = CGPoint()
    
    let touchRadius = CGFloat(30)
    
    private var imageView: UIImageView?
    private var angleToolDrawing = AngleToolDrawing()

    init() {
        self.dotPositions = [beginDotPosition, middleDotPosition, endDotPosition]
    }
    
    func  setJointMotion(jointMotion: JointMotion) {
        let rotationCW = jointMotion.rotation == "CW"
        angleToolDrawing.rotationCW = rotationCW
        let quadrant = calcQuadrant(rotationCW: rotationCW, insideOutside: jointMotion.insideOutside!)
        angleToolDrawing.angleQuadrant = quadrant

    }
    
    //Quadrant0 is main arm, Quadrant180 is main arm extended, angle is CW
    private func calcQuadrant(rotationCW: Bool, insideOutside: String) -> String {
        var quadrant = "Quadrant0"
        if insideOutside == "Outside" {
            quadrant = "Quadrant180"
        }
        if insideOutside == "Outside-90" && rotationCW || insideOutside == "Inside-90" && !rotationCW {
            //extension 90 degree clockwise
            quadrant = "Quadrant90"
        } else if insideOutside == "Outside-90" && !rotationCW || insideOutside == "Inside-90" && rotationCW {
            //extension 90 degree counter clockwise
            quadrant = "Quadrant270"
        }
        return quadrant
    }
    
    func setMeasurementObj(measurementObj: Measurement) {
        measurement = measurementObj
        setJointMotion(jointMotion: (measurement?.jointMotion)!)
    }

    func setImageView(imageView: UIImageView) {
        //If not the first imageview then just recalc the tool location and redraw
        //Needed for rotation of screen
        if self.imageView != nil {
            restoreLocation()
            angleToolDrawing.drawTool(dotPositions: dotPositions)
            return //
        }
        self.imageView = imageView
        
        angleToolDrawing.setImageView(imageView: imageView)
        restoreLocation()
        
        //1000 magic number that makes the scale look good
        angleToolDrawing.scaleTool(scale: imageView.bounds.height / 1000)
        
        angleToolDrawing.drawTool(dotPositions: dotPositions)
        
    }
    
    func measuredAngle() -> CGFloat {
        return angleToolDrawing.measuredAngle
    }

    //Restore dot positions from core data or use default
    fileprivate func restoreLocation() {
        let fullResEntity = measurement?.fullRes
        if fullResEntity != nil {
            //convert pixel positions to image view locations
            let imageTransform = calculateImageTransform(imageView: imageView!)
            var pixelPosition = CGPoint()
            
            pixelPosition.x = CGFloat((measurement?.beginX)!)
            pixelPosition.y = CGFloat((measurement?.beginY)!)
            dotPositions[0] = convertPixelToLocation(position: pixelPosition, origin: imageTransform.rect.origin, scale: imageTransform.scale)
            
            pixelPosition.x = CGFloat((measurement?.middleX)!)
            pixelPosition.y = CGFloat((measurement?.middleY)!)
            dotPositions[1] = convertPixelToLocation(position: pixelPosition, origin: imageTransform.rect.origin, scale: imageTransform.scale)
            
            pixelPosition.x = CGFloat((measurement?.endX)!)
            pixelPosition.y = CGFloat((measurement?.endY)!)
            dotPositions[2] = convertPixelToLocation(position: pixelPosition, origin: imageTransform.rect.origin, scale: imageTransform.scale)
        } else {
            dotPositions[1] = (imageView?.center)!
            dotPositions[0] = dotPositions[1]
            dotPositions[0].y += (imageView?.frame.height)!/6

            dotPositions[2] = dotPositions[1]
            dotPositions[2].x += (imageView?.frame.width)!/5
        }
    }
    
    //Save dot positions as image pixels to core data
    func saveLocation() {
        let imageTransform = calculateImageTransform(imageView: imageView!)
        var pixelDotPosition = CGPoint()
        
        pixelDotPosition = convertLocationToPixel(location: dotPositions[0], origin: imageTransform.rect.origin, scale: imageTransform.scale)
        measurement?.beginX = Float(pixelDotPosition.x)
        measurement?.beginY = Float(pixelDotPosition.y)

        pixelDotPosition = convertLocationToPixel(location: dotPositions[1], origin: imageTransform.rect.origin, scale: imageTransform.scale)
        measurement?.middleX = Float(pixelDotPosition.x)
        measurement?.middleY = Float(pixelDotPosition.y)

        pixelDotPosition = convertLocationToPixel(location: dotPositions[2], origin: imageTransform.rect.origin, scale: imageTransform.scale)
        measurement?.endX = Float(pixelDotPosition.x)
        measurement?.endY = Float(pixelDotPosition.y)
    }
 
    //Scale the pixel position to a location in the image view
    fileprivate func convertPixelToLocation(position: CGPoint, origin: CGPoint, scale: CGFloat) -> CGPoint {
        var location = CGPoint()
        
        location.x = position.x * scale + origin.x
        location.y = position.y * scale + origin.y
        
        return location
    }
    
    //Scale the location in the image view to a pixel location
    fileprivate func convertLocationToPixel(location: CGPoint, origin: CGPoint, scale: CGFloat) -> CGPoint {
        var pixelDotPosition = CGPoint()

        pixelDotPosition.x = (location.x - origin.x) / scale
        pixelDotPosition.y = (location.y - origin.y) / scale
        
        return pixelDotPosition
    }
    
    // Assumes the image is aspectFit in imageview
    //centered with either width or height the same
    fileprivate func calculateImageTransform(imageView: UIImageView) -> (rect:CGRect, scale:CGFloat) {
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
        
        // Add imageView offset
        imageRect.origin.x += imageView.frame.origin.x
        imageRect.origin.y += imageView.frame.origin.y
        
        return (imageRect, aspect)
    }
    
    //Detect touches close to tool points and center of lines
    func pointInTool(inside point: CGPoint) -> Bool {
        var inTool = false
        //check for end points
        for position in dotPositions {
            let distance = hypot(position.x - point.x, position.y - point.y)
            if distance < touchRadius { //Touch within touchRadius units
                inTool = true
            }
        }
        //check for mid lines
        let beginLinePosition = linePosition(startPoint: dotPositions[0], endPoint: dotPositions[1])
        let endLinePosition = linePosition(startPoint: dotPositions[1], endPoint: dotPositions[2])
        
        let beginLineDistance = hypot(beginLinePosition.x - point.x, beginLinePosition.y - point.y)
        let endLineDistance = hypot(endLinePosition.x - point.x, endLinePosition.y - point.y)

        if beginLineDistance < touchRadius {
            inTool = true
        }
        
        if endLineDistance < touchRadius {
            inTool = true
        }

        return inTool
    }
    
    fileprivate func invertRotation() {
        let rotation = measurement?.jointMotion?.rotation
        if rotation == "CW" {
            measurement?.jointMotion?.rotation = "CCW"
        } else {
            measurement?.jointMotion?.rotation = "CW"
        }
    }
    
    func doHandleDotPan(gestureRecognizer: UIPanGestureRecognizer, view: UIView) {
        if gestureRecognizer.state == .began {
            panStart = gestureRecognizer.location(in: view)
            let beginDistance = hypot(dotPositions[0].x - panStart.x, dotPositions[0].y - panStart.y)
            let middleDistance = hypot(dotPositions[1].x - panStart.x, dotPositions[1].y - panStart.y)
            let endDistance = hypot(dotPositions[2].x - panStart.x, dotPositions[2].y - panStart.y)
            
            //   Set movingDotIndex to the nearest dot to move
            let nearestDot = min(min(beginDistance, middleDistance), endDistance)
            if nearestDot < touchRadius {
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
            } else {
                let beginLinePosition = linePosition(startPoint: dotPositions[0], endPoint: dotPositions[1])
                let beginLineDistance = hypot(beginLinePosition.x - panStart.x, beginLinePosition.y - panStart.y)

                let endLinePosition = linePosition(startPoint: dotPositions[1], endPoint: dotPositions[2])
                let endLineDistance = hypot(endLinePosition.x - panStart.x, endLinePosition.y - panStart.y)

                panBeginStartPosition = dotPositions[0]
                panMiddleStartPosition = dotPositions[1]
                panEndStartPosition = dotPositions[2]

                movingDotIndex = -3 //Assume no line close
                if beginLineDistance < touchRadius {
                    movingDotIndex = -1
                }
                
                if endLineDistance < 30 {
                    movingDotIndex = -2
                }
            }
            
        } else if gestureRecognizer.state == .changed {
            let translation = gestureRecognizer.translation(in: view)
            
            if movingDotIndex >= 0 {
                dotPositions[movingDotIndex] = CGPoint(x: dotStartPosition.x + translation.x, y: dotStartPosition.y + translation.y)
                angleToolDrawing.drawTool(dotPositions: dotPositions)
            } else {
                if movingDotIndex == -1 {
                    //move the begin line
                    dotPositions[0] = CGPoint(x: panBeginStartPosition.x + translation.x, y: panBeginStartPosition.y + translation.y)
                    //recalculate the axis position keeping the arms at the original angle
                    let translatedMiddleDot = CGPoint(x: panMiddleStartPosition.x + translation.x, y: panMiddleStartPosition.y + translation.y)
                    dotPositions[1] = intersectPosition(p1: dotPositions[0], p2: translatedMiddleDot, p3: panEndStartPosition, p4: panMiddleStartPosition)
                    angleToolDrawing.drawTool(dotPositions: dotPositions)
                } else if movingDotIndex == -2 {
                    //move the end line
                    dotPositions[2] = CGPoint(x: panEndStartPosition.x + translation.x, y: panEndStartPosition.y + translation.y)
                    //recalculate the axis position keeping the arms at the original angle
                    let translatedMiddleDot = CGPoint(x: panMiddleStartPosition.x + translation.x, y: panMiddleStartPosition.y + translation.y)
                    dotPositions[1] = intersectPosition(p1: dotPositions[2], p2: translatedMiddleDot, p3: panBeginStartPosition, p4:panMiddleStartPosition)
                    angleToolDrawing.drawTool(dotPositions: dotPositions)
                }
            }
        }
    }
    
    /*
     If both lines are each given by two points, first line points:     (x1 , y1) , (x2 , y2) and the second line is given by two points:
     (x3 , y3) , (x4 , y4)
 
     The intersection point (x , y) is found by the equation:

    */
    fileprivate func intersectPosition(p1: CGPoint, p2: CGPoint, p3: CGPoint, p4: CGPoint) -> CGPoint {
        var middlePosition = CGPoint()
        
        let xNum1 = ((p2.x * p1.y) - (p1.x * p2.y)) * (p4.x - p3.x)
        let xNum2 = ((p4.x * p3.y) - (p3.x * p4.y)) * (p2.x - p1.x)
        
        let denom = (p2.x - p1.x) * (p4.y - p3.y) - (p4.x - p3.x) * (p2.y - p1.y)
        
        middlePosition.x = (xNum1 - xNum2) / denom

        let yNum1 = ((p2.x * p1.y) - (p1.x * p2.y)) * (p4.y - p3.y)
        let yNum2 = ((p4.x * p3.y) - (p3.x * p4.y)) * (p2.y - p1.y)
        
        middlePosition.y = (yNum1 - yNum2) / denom

        return middlePosition
    }
    
    //Calculate the midpoint of the line
    fileprivate func linePosition(startPoint: CGPoint, endPoint: CGPoint) -> CGPoint {
        let linePosition = CGPoint(x: startPoint.x + (endPoint.x - startPoint.x) / 2, y: startPoint.y + (endPoint.y - startPoint.y) / 2)
        return linePosition
    }


}
