//
//  BodyJoints.swift
//  goniometer
//
//  Created by Steven Gallagher on 12/24/17.
//  Copyright © 2017 Steven Gallagher. All rights reserved.
//

import UIKit
import CoreData

struct NameType {
    var common: String
    var medical: String
}

struct JointMotionStruct {
    var motion: NameType
    var stationaryLabel: NameType
    var axisLabel: NameType
    var movingLabel: NameType
    var normalAMA: String
    var normalAAOS: String
    var position: String
}

struct Joint {
    var name: NameType
    var motions: [JointMotionStruct]
}

let shoulderJoint = Joint.init(name: .init(common: "Shoulder", medical: ""),
                               motions: [
                                JointMotionStruct.init(motion: .init(common: "Arm Raise", medical: "Flexion"),
                                    stationaryLabel: .init(common: "Back", medical: "Mid-axillary Line"),
                                    axisLabel: .init(common: "Shoulder", medical: "Head of humerus"),
                                    movingLabel: .init(common: "Elbow", medical: "Midline of Humerus"),
                                    normalAMA: "150",
                                    normalAAOS: "167,4.7",
                                    position: ""),
                                JointMotionStruct.init(motion: .init(common: "Arm Reverse Raise", medical: "Extension"),
                                    stationaryLabel: .init(common: "Back", medical: "Mid-axillary Line"),
                                    axisLabel: .init(common: "Shoulder", medical: "Acromium Process (center of humeral head)"),
                                    movingLabel: .init(common: "Elbow", medical: "Lateral Epicondyle"),
                                    normalAMA: "50",
                                    normalAAOS: "62,9.5",
                                    position: "")])


let kneeJoint = Joint.init(name: .init(common: "Knee", medical: ""),
                           motions: [
                            JointMotionStruct.init(motion: .init(common: "Bend", medical: "Flexion"),
                                stationaryLabel: .init(common: "Hip Bone", medical: "Greater Trochanter"),
                                axisLabel: .init(common: "Knee", medical: "Lateral Epicondyle"),
                                movingLabel: .init(common: "Ankle", medical: "Lateral Malleolus"),
                                normalAMA: "150",
                                normalAAOS: "141,5.3",
                                position: "")])

let joints = [shoulderJoint, kneeJoint]

class BodyJoints {
    
    init() {
        jointMotions()
//        addJoints()
    }
    
    fileprivate func addJoints() {
        for joint in joints {
            addJoint(joint: joint)
        }
    }

    fileprivate func addJoint(joint: Joint) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext =  appDelegate.persistentContainer.viewContext


        for motion in joint.motions {
            //Create a new jointMotion object
            let entity = NSEntityDescription.entity(forEntityName: "JointMotion", in: managedContext)!
            let jointMotion = JointMotion(entity: entity, insertInto: managedContext)
            
            jointMotion.nameCommon = joint.name.common
            jointMotion.nameMedical = joint.name.medical

            jointMotion.motionCommon = motion.motion.common
            jointMotion.motionMedical = motion.motion.medical
            
            jointMotion.stationaryLabelCommon = motion.stationaryLabel.common
            jointMotion.stationaryLabelMedical = motion.stationaryLabel.medical
            
            jointMotion.axisLabelCommon = motion.axisLabel.common
            jointMotion.axisLabelMedical = motion.axisLabel.medical
            
            jointMotion.movingLabelCommon = motion.movingLabel.common
            jointMotion.movingLabelMedical = motion.movingLabel.medical
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save jointMotion. \(error), \(error.userInfo)")
        }

    }
    
    fileprivate func jointMotions() {
        var jointData: [JointMotion] = []
        // Our result is going to be an array of dictionaries.
        var results:[[String:AnyObject]]?

        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "JointMotion")
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "JointMotion")
        
        let filter = "Shoulder"
        let predicate = NSPredicate(format: "nameCommon = %@", filter)
        fetchRequest.predicate = predicate
        fetchRequest.resultType = .dictionaryResultType
        fetchRequest.propertiesToFetch = ["motionCommon", "motionMedical"]

        do {
            results = try managedContext.fetch(fetchRequest) as? [[String : AnyObject]]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
//    Printing description of results:
//    ▿ Optional<Array<Dictionary<String, AnyObject>>>
//    ▿ some : 2 elements
//    ▿ 0 : 2 elements
//    ▿ 0 : 2 elements
//    - key : "motionMedical"
//    - value : Extension
//    ▿ 1 : 2 elements
//    - key : "motionCommon"
//    - value : Arm Reverse Raise
//    ▿ 1 : 2 elements
//    ▿ 0 : 2 elements
//    - key : "motionMedical"
//    - value : Flexion
//    ▿ 1 : 2 elements
//    - key : "motionCommon"
//    - value : Arm Raise

    
    fileprivate func saveJoint() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext =  appDelegate.persistentContainer.viewContext
        
        //Create a new jointMotion object
        var jointMotion = JointMotion()
        //        jointMotion.nameCommon = "Knee"
        
        
        let entity = NSEntityDescription.entity(forEntityName: "JointMotion", in: managedContext)!
        jointMotion = JointMotion(entity: entity, insertInto: managedContext)
        
        jointMotion.nameCommon = "Shoulder"
        
        jointMotion.motionCommon = "Arm Raise"
        jointMotion.motionMedical = "Flexion"
        
        jointMotion.stationaryLabelCommon = "Back"
        jointMotion.stationaryLabelMedical = "Mid-axillary Line"
        
        jointMotion.axisLabelCommon = "Shoulder"
        jointMotion.axisLabelMedical = "Head of Humerus"
        
        jointMotion.movingLabelCommon = "Elbow"
        jointMotion.movingLabelMedical = "Midline of Humerus"
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save jointMotion. \(error), \(error.userInfo)")
        }
        
    }

}




