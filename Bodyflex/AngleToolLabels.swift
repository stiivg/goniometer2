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
    
    let stationaryMedicalTextLayer = CATextLayer()
    let axisMedicalTextLayer = CATextLayer()
    let movingMedicalTextLayer = CATextLayer()
    
    let fontFrameSizeDefault = CGSize(width: 140, height: 15)
    let commonFontSizeDefault = CGFloat(12)
    let medicalFontSizeDefault = CGFloat(9)
    
    let labelOffset = CGFloat(32)
    let medicalOffset = CGFloat(15)

    var fontFrameSize = CGSize(width: 60, height: 20)
    var commonFontSize = CGFloat(12)
    var medicalFontSize = CGFloat(9)

    var motion: MotionStruct?
    var side = "Right"

    init() {
        initTextLayer(textLayer: stationaryCommonTextLayer)
        initTextLayer(textLayer: axisCommonTextLayer)
        initTextLayer(textLayer: movingCommonTextLayer)
        
        initTextLayer(textLayer: stationaryMedicalTextLayer)
        initTextLayer(textLayer: axisMedicalTextLayer)
        initTextLayer(textLayer: movingMedicalTextLayer)
    }

    func setImageView(imageView: UIImageView) {
        imageView.layer.addSublayer(stationaryCommonTextLayer)
        imageView.layer.addSublayer(axisCommonTextLayer)
        imageView.layer.addSublayer(movingCommonTextLayer)
        
        imageView.layer.addSublayer(stationaryMedicalTextLayer)
        imageView.layer.addSublayer(axisMedicalTextLayer)
        imageView.layer.addSublayer(movingMedicalTextLayer)
    }
    
    func setMotion(motion: MotionStruct) {
        self.motion = motion
    }
    
    fileprivate func initTextLayer(textLayer: CATextLayer) {
        let fontName: CFString = "HelveticaNeue" as CFString
        textLayer.font = CTFontCreateWithName(fontName, 8, nil)
        textLayer.opacity = 1.0
//        textLayer.cornerRadius = 5
        textLayer.backgroundColor = UIColor.white.withAlphaComponent(0.5).cgColor
        
        textLayer.foregroundColor = UIColor.black.cgColor
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
        
        stationaryMedicalTextLayer.frame.size = fontFrameSize
        stationaryMedicalTextLayer.fontSize = medicalFontSize
        
        axisMedicalTextLayer.frame.size = fontFrameSize
        axisMedicalTextLayer.fontSize = medicalFontSize
        
        movingMedicalTextLayer.frame.size = fontFrameSize
        movingMedicalTextLayer.fontSize = medicalFontSize
        
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
        
        var medicalPosition: CGPoint
        
        stationaryMedicalTextLayer.string = theMotion.stationaryLabel.medical
        medicalPosition = labelPosition(offset: theMotion.labelOffsets[0], textLayer: stationaryMedicalTextLayer, dotPosition: dotPositions[0])
        medicalPosition.y += medicalOffset
        stationaryMedicalTextLayer.position = medicalPosition
        
        axisMedicalTextLayer.string = theMotion.axisLabel.medical
        medicalPosition = labelPosition(offset: theMotion.labelOffsets[1], textLayer: axisMedicalTextLayer, dotPosition: dotPositions[1])
        medicalPosition.y += medicalOffset
        axisMedicalTextLayer.position = medicalPosition
        
        movingMedicalTextLayer.string = theMotion.movingLabel.medical
        medicalPosition = labelPosition(offset: theMotion.labelOffsets[2], textLayer: movingMedicalTextLayer, dotPosition: dotPositions[2])
        medicalPosition.y += medicalOffset
        movingMedicalTextLayer.position = medicalPosition
        
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
            textLayer.alignmentMode = kCAAlignmentCenter
        case "Down":
            yOffset = labelOffset
            textLayer.alignmentMode = kCAAlignmentCenter
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



