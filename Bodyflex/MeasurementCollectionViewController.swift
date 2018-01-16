//
//  MeasurementCollectionViewController.swift
//  bodyflex
//
//  Created by Steven Gallagher on 1/4/18.
//  Copyright © 2018 Steven Gallagher. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "CollectionCell"


class MeasurementCollectionViewController: UICollectionViewController {

    var displayIndex = IndexPath(item: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)

    }
    
    @objc func doubleTapped() {
        //Segue modally to angle measure
        performSegue(withIdentifier: "CollectionToAngleMeasure", sender: nil)
    }
    
    // MARK: - Properties
    var allMeasurements = MeasurementsAPI.shared.getMeasurements()
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

        self.collectionView?.reloadData()
        
        scrollToIndex(index: displayIndex)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "CollectionToAngleMeasure" {
            //save the current cell index for return
            displayIndex = (collectionView?.indexPathsForVisibleItems[0])!

            let nav = segue.destination as! UINavigationController
            let measureAngleViewController = nav.topViewController as? MeasureAngleViewController
            let visibleCells = collectionView?.visibleCells as! [MeasurementCollectionCell]
            let measurement = visibleCells[0].measurement
            // Pass the selected object to the new view controller.
            measureAngleViewController?.setMeasurement(newMeasurement: measurement!)
        }
    }

    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return allMeasurements.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MeasurementCollectionCell", for: indexPath) as! MeasurementCollectionCell
    
        // Configure the cell
        
        if allMeasurements.count > 0 {
            let measurement = allMeasurements[indexPath.item]
            cell.measurement = measurement
        }
        
        return cell
    }
    
    fileprivate func scrollToIndex(index: IndexPath) {
        self.collectionView!.scrollToItem(at:index, at: .right, animated: false)
    }
    
    @IBAction func cancelMeasurementEdit(_ segue: UIStoryboardSegue) {
        MeasurementsAPI.shared.cancelMeasurementEdit()
    }
    
    // Return from editing existing measurement
    @IBAction func saveMeasurementEdit(_ segue: UIStoryboardSegue) {
        //Notify the edit view to complete all edits
        let measureAngleViewController = segue.source as! MeasureAngleViewController
        measureAngleViewController.completeEdit()
        
        MeasurementsAPI.shared.saveMeasurement()
        
        // update the tableView
        self.collectionView!.reloadData()
    }
    
    //    func collectionView(_ collectionView: UICollectionView,
//                                 layout collectionViewLayout: UICollectionViewLayout,
//                                 sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width, height: view.frame.height)
//    }



    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}


//Force the collection to display each cell the size of the bounds
extension MeasurementCollectionViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

