//
//  AngleToolLabels.swift
//  Bodyflex
//
//  Created by Steven Gallagher on 1/30/18.
//  Copyright © 2018 Steven Gallagher. All rights reserved.
//

import UIKit

class AngleToolLabels {

    let stationaryCommonTextLayer = CATextLayer()
    let axisCommonTextLayer = CATextLayer()
    let movingCommonTextLayer = CATextLayer()

    let fontFrameSizeDefault = CGSize(width: 140, height: 20)
    let commonFontSizeDefault = CGFloat(12)
    let medicalFontSizeDefault = CGFloat(9)
    
    let labelOffset = CGFloat(30)

    var fontFrameSize = CGSize(width: 60, height: 20)
    var commonFontSize = CGFloat(12)
    var medicalFontSize = CGFloat(9)

    var motion: MotionStruct?
    var side = "Right"

    init() {
        initTextLayer(textLayer: stationaryCommonTextLayer)
        initTextLayer(textLayer: axisCommonTextLayer)
        initTextLayer(textLayer: movingCommonTextLayer)
    }

    func setImageView(imageView: UIImageView) {
        imageView.layer.addSublayer(stationaryCommonTextLayer)
        imageView.layer.addSublayer(axisCommonTextLayer)
        imageView.layer.addSublayer(movingCommonTextLayer)
    }
    
    func setMotion(motion: MotionStruct) {
        self.motion = motion
    }
    
    fileprivate func initTextLayer(textLayer: CATextLayer) {
        let fontName: CFString = "HelveticaNeue" as CFString
        textLayer.font = CTFontCreateWithName(fontName, 8, nil)
        textLayer.opacity = 1.0
        
        textLayer.foregroundColor = UIColor.black.cgColor
        textLayer.backgroundColor = UIColor.cyan.cgColor
        textLayer.alignmentMode = kCAAlignmentLeft
        textLayer.contentsScale = UIScreen.main.scale
    }
    
    fileprivate func scaleTextLayer(scale: CGFloat) {
        fontFrameSize = CGSize(width: fontFrameSizeDefault.width * scale, height: fontFrameSizeDefault.height * scale)
        commonFontSize = commonFontSizeDefault * scale
        medicalFontSize = medicalFontSizeDefault * scale
        
        stationaryCommonTextLayer.frame.size = fontFrameSize
        stationaryCommonTextLayer.fontSize = commonFontSize
        
        axisCommonTextLayer.frame.size = fontFrameSize
        axisCommonTextLayer.fontSize = commonFontSize
        
        movingCommonTextLayer.frame.size = fontFrameSize
        movingCommonTextLayer.fontSize = commonFontSize
    }


    func drawLabels(dotPositions: [CGPoint]) {
        guard let theMotion = self.motion else { return }
        scaleTextLayer(scale: 1.0)

        stationaryCommonTextLayer.string = theMotion.stationaryLabel.common
        stationaryCommonTextLayer.position = labelPosition(offset: theMotion.labelOffsets[0], textLayer: stationaryCommonTextLayer, dotPosition: dotPositions[0])
        
        axisCommonTextLayer.string = theMotion.axisLabel.common
        axisCommonTextLayer.position = labelPosition(offset: theMotion.labelOffsets[1], textLayer: axisCommonTextLayer, dotPosition: dotPositions[1])
        
        movingCommonTextLayer.string = theMotion.movingLabel.common
        movingCommonTextLayer.position = labelPosition(offset: theMotion.labelOffsets[2], textLayer: movingCommonTextLayer, dotPosition: dotPositions[2])
        
    }
    
    func labelPosition(offset: String, textLayer: CATextLayer, dotPosition: CGPoint) -> CGPoint {
        var position = CGPoint()
        var xOffset = CGFloat(0)
        var yOffset = CGFloat(0)
        
        var offsetWithSide = offset
        if side == "Left" {
            if offset == "Left" {
                offsetWithSide = "Right"
            }
            if offset == "Right" {
                offsetWithSide = "Left"
            }
        }
        
        switch offsetWithSide {
        case "Up":
            yOffset = -labelOffset
        case "Down":
            yOffset = labelOffset
        case "Left":
            xOffset = -labelOffset - textLayer.bounds.width / 2
            textLayer.alignmentMode = kCAAlignmentRight

        case "Right":
            xOffset = labelOffset + textLayer.bounds.width / 2
            textLayer.alignmentMode = kCAAlignmentLeft
        default:
            break
        }
        position = CGPoint(x: dotPosition.x + xOffset, y: dotPosition.y + yOffset)
        return position
    }
}



