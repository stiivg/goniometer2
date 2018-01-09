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
                                    axisLabel: .init(common: "Shoulder", medical: "Head of Humerus"),
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
                                    position: ""),
                                JointMotionStruct.init(motion: .init(common: "Arm Raise to Side", medical: "Abduction"),
                                    stationaryLabel: .init(common: "Side", medical: "Parallel to Sternum"),
                                    axisLabel: .init(common: "Shoulder", medical: "Humeral Head"),
                                    movingLabel: .init(common: "Elbow", medical: "Midline of Humerus"),
                                    normalAMA: "180",
                                    normalAAOS: "184,7.0",
                                    position: ""),
                                JointMotionStruct.init(motion: .init(common: "Bent Arm Lower", medical: "Medial Rotation"),
                                    stationaryLabel: .init(common: "Vertical", medical: ""),
                                    axisLabel: .init(common: "Elbow", medical: "Olecranon Process"),
                                    movingLabel: .init(common: "Wrist", medical: "Ulnar Styloid"),
                                    normalAMA: "90",
                                    normalAAOS: "69,4.6",
                                    position: ""),
                                JointMotionStruct.init(motion: .init(common: "Bent Arm Raise", medical: "Lateral Rotation"),
                                    stationaryLabel: .init(common: "Vertical", medical: ""),
                                    axisLabel: .init(common: "Elbow", medical: "Olecranon Process"),
                                    movingLabel: .init(common: "Wrist", medical: "Ulnar Styloid"),
                                    normalAMA: "90",
                                    normalAAOS: "104,8.5",
                                    position: "")])

let elbowJoint = Joint.init(name: .init(common: "Elbow", medical: ""),
                           motions: [
                            JointMotionStruct.init(motion: .init(common: "Curl", medical: "Flexion"),
                                stationaryLabel: .init(common: "Shoulder", medical: "Acromion Process"),
                                axisLabel: .init(common: "Elbow", medical: "Lateral Epicondyle"),
                                movingLabel: .init(common: "Wrist", medical: "Radial Styloid"),
                                normalAMA: "140",
                                normalAAOS: "141,4.9",
                                position: ""),
                            JointMotionStruct.init(motion: .init(common: "Straighten Arm", medical: "Extension"),
                                stationaryLabel: .init(common: "Shoulder", medical: "Acromion Process"),
                                axisLabel: .init(common: "Elbow", medical: "Lateral Epicondyle"),
                                movingLabel: .init(common: "Wrist", medical: "Radial Styloid"),
                                normalAMA: "0",
                                normalAAOS: "0.3,2.0",
                                position: "")])

let forearm = Joint.init(name: .init(common: "Elbow", medical: ""),
                            motions: [
                                JointMotionStruct.init(motion: .init(common: "Palm Up", medical: "Supination"),
                                                       stationaryLabel: .init(common: "Parallel to Upper Arm", medical: "Parallel to Humerus"),
                                                       axisLabel: .init(common: "Inside Wrist", medical: "Medial to Ulnar Styloid"),
                                                       movingLabel: .init(common: "Outside Wrist", medical: "Ventral Aspect of Distal Radius"),
                                                       normalAMA: "80",
                                                       normalAAOS: "81,4.0",
                                                       position: ""),
                                JointMotionStruct.init(motion: .init(common: "Palm Down", medical: "Pronation"),
                                                       stationaryLabel: .init(common: "Parallel to Upper Arm", medical: "Parallel to Humerus"),
                                                       axisLabel: .init(common: "Outside Wrist", medical: "Lateral to Ulnar Styloid"),
                                                       movingLabel: .init(common: "Inside Wrist", medical: "Dorsal Aspect of Distal Radius"),
                                                       normalAMA: "80",
                                                       normalAAOS: "75,5.3",
                                                       position: "")])

let wristJoint = Joint.init(name: .init(common: "Wrist", medical: ""),
                         motions: [
                            JointMotionStruct.init(motion: .init(common: "Hand Lowered", medical: "Flexion"),
                                                   stationaryLabel: .init(common: "Parallel to Lower Arm", medical: "Ulna"),
                                                   axisLabel: .init(common: "Wrist", medical: "Triquetum"),
                                                   movingLabel: .init(common: "Hand", medical: "5th Metacarpal"),
                                                   normalAMA: "60",
                                                   normalAAOS: "75,6.6",
                                                   position: ""),
                            JointMotionStruct.init(motion: .init(common: "Hand Raised", medical: "Extension"),
                                                   stationaryLabel: .init(common: "Parallel to Lower Arm", medical: "Ulna"),
                                                   axisLabel: .init(common: "Wrist", medical: "Triquetum"),
                                                   movingLabel: .init(common: "Hand", medical: "5th Metacarpal"),
                                                   normalAMA: "60",
                                                   normalAAOS: "74,6.6",
                                                   position: ""),
                            JointMotionStruct.init(motion: .init(common: "Hand Out", medical: "Radial Deviation"),
                                                   stationaryLabel: .init(common: "Elbow", medical: "Lateral Epicondyle"),
                                                   axisLabel: .init(common: "Wrist", medical: "Capitate"),
                                                   movingLabel: .init(common: "Middle Finger", medical: "Middle Metacarpal"),
                                                   normalAMA: "20",
                                                   normalAAOS: "21,4.0",
                                                   position: ""),
                            JointMotionStruct.init(motion: .init(common: "Hand In", medical: "Ulnar Deviation"),
                                                   stationaryLabel: .init(common: "Elbow", medical: "Lateral Epicondyle"),
                                                   axisLabel: .init(common: "Wrist", medical: "Capitate"),
                                                   movingLabel: .init(common: "Middle Finger", medical: "Middle Metacarpal"),
                                                   normalAMA: "30",
                                                   normalAAOS: "35,3.8",
                                                   position: "")])

let knuckleJoint = Joint.init(name: .init(common: "Knuckle", medical: "Metacarpophalangeal"),
                            motions: [
                                JointMotionStruct.init(motion: .init(common: "Lower Fingers", medical: "Flexion"),
                                                       stationaryLabel: .init(common: "Back of Hand", medical: "Aligned with Metacarpal"),
                                                       axisLabel: .init(common: "Knuckle", medical: "Dorsal Metacarpophalangeal Joint"),
                                                       movingLabel: .init(common: "Finger", medical: "Aligned with Proximal Phalange"),
                                                       normalAMA: "90",
                                                       normalAAOS: "86",
                                                       position: ""),
                                JointMotionStruct.init(motion: .init(common: "Raise Fingers", medical: "Extension"),
                                                       stationaryLabel: .init(common: "Back of Hand", medical: "Aligned with Metacarpal"),
                                                       axisLabel: .init(common: "Knuckle", medical: "Dorsal Metacarpophalangeal Joint"),
                                                       movingLabel: .init(common: "Finger", medical: "Aligned with Proximal Phalange"),
                                                       normalAMA: "20",
                                                       normalAAOS: "22",
                                                       position: ""),
                                JointMotionStruct.init(motion: .init(common: "Separate Fingers", medical: "Abduction"),
                                                       stationaryLabel: .init(common: "Back of Hand", medical: "Aligned with Metacarpal"),
                                                       axisLabel: .init(common: "Knuckle", medical: "Dorsal Metacarpophalangeal Joint"),
                                                       movingLabel: .init(common: "Finger", medical: "Aligned with Proximal Phalange"),
                                                       normalAMA: "",
                                                       normalAAOS: "",
                                                       position: ""),
                                JointMotionStruct.init(motion: .init(common: "Fingers from Thumb", medical: "Adduction"),
                                                       stationaryLabel: .init(common: "Back of Hand", medical: "Aligned with Metacarpal"),
                                                       axisLabel: .init(common: "Knuckle", medical: "Dorsal Metacarpophalangeal Joint"),
                                                       movingLabel: .init(common: "Finger", medical: "Aligned with Proximal Phalange"),
                                                       normalAMA: "",
                                                       normalAAOS: "",
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

let joints = [shoulderJoint, elbowJoint,  forearm, wristJoint, kneeJoint]

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




