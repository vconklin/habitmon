//
//  CollectionCollectionViewController.swift
//  Habitmon
//
//  Created by VAL on 2016/08/22.
//  Copyright © 2016年 VAL. All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "Cell"

class CollectionCollectionViewController: UICollectionViewController {
  
  var habitmons: Results<Habit>!

  // for tab bar.. this isn't working yet though
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    // Initialize Tab Bar Item
    tabBarItem = UITabBarItem(title: "Collection", image: UIImage(named: "CollectionIcon"), tag: 2)
  }
  
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    
    
//        let nib = UINib(nibName: "UICollectionElementKindCell", bundle:nil)
//        self.collectionView!.registerNib(nib, forCellWithReuseIdentifier: "CollectionCollectionViewCell")
    
//        collectionView!.registerClass(NSClassFromString("CollectionCollectionViewCell"),forCellWithReuseIdentifier: "cell")
    
        habitmons = try! Realm().objects(Habit)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return habitmons.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      
        let habitmon = habitmons[indexPath.item]
      
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionCollectionViewCell
    
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
          cell.name.text = habitmon.habitmon
        cell.backgroundColor = UIColor.grayColor() // make cell more visible in our example project
      
        return cell
    }
  
      override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
      }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}