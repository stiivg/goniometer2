//
//  GestureScrollView.swift
//  bodyflex
//
//  Created by Steven Gallagher on 12/8/17.
//  Copyright © 2017 Steven Gallagher. All rights reserved.
//

import UIKit



class GestureScrollView: UIScrollView , UIGestureRecognizerDelegate{

    var angleTool = AngleTool()
    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }

    func setAngleTool(theAngleTool: AngleTool) {
        angleTool = theAngleTool
    }
    
    //Returns false if in the tool points and should be ignored by this scroll view
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let toolPoint = self.convert(point, to: self.subviews[0])
        if angleTool.pointInTool(inside: toolPoint) {
            return false
        }
        return true
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
