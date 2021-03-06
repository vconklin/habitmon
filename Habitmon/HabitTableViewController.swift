//
//  HabitTableViewController.swift
//  Habitmon
//
//  Created by VAL on 2016/08/11.
//  Copyright © 2016年 VAL. All rights reserved.
//

import UIKit
import RealmSwift

class HabitTableViewController: UITableViewController {
  
  let realm = try! Realm()
  var habits: Results<Habit>!
  
  // for setting up the tab bar
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    // Initialize Tab Bar Item
    tabBarItem = UITabBarItem(title: "Habits", image: UIImage(named: "HabitsIcon"), tag: 1)
  }
  
  func loadHabits() {
    habits = try! Realm().objects(Habit).filter("active = true").sorted("level")
  }
  
  func tutorialPopup() {
    
    let tutorialAlert = UIAlertController(title: "How To Use This App", message: "", preferredStyle: UIAlertControllerStyle.Alert)
    
    tutorialAlert.message = "The 'Habits' tab shows the daily habits and lifestyle changes you're currently working on. Use the '+' button to add a new habit to work on, represented by its own unique monster. \n \n You can check off that you completed a habit once every 12 hours. Each time you check off your habit, your Habitmon will grow! \n \n At certain levels, your Habitmon will evolve into a brand new Habitmon, which gets added to your Collection. The 'Collection' tab shows a list of all the Habitmon you have ever collected. Collect 'em all!"
    
    tutorialAlert.addAction(UIAlertAction(title: "Got it!", style: .Default, handler: { (action: UIAlertAction!) in
      // the tutorial has now been seen
      try! self.realm.write {
        self.realm.objects(User)[0].seenTutorial = true
      }
    }))
    
    presentViewController(tutorialAlert, animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    // if it's the first time they've launched the app), then show the tutorial
    if realm.objects(User)[0].seenTutorial == false {
      tutorialPopup()
    }
    
    loadHabits()
  }
  
  override func viewWillAppear(animated: Bool) {
    //so that the table data will refresh when the page is visited again
    let footerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.tableView.frame.size.width, height: 0.5))
    
    footerView.backgroundColor = UIColor.lightGrayColor()
    
    self.tableView.tableFooterView = footerView
    
    self.tableView.reloadData()
  }
  
  // MARK: TableView Delegate Methods
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return habits.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    // Table view cells are reused and should be dequeued using a cell identifier.
    let cellIdentifier = "HabitTableViewCell"
    
    // Fetches the appropriate habit for the data source layout.
    let habit = habits[indexPath.row]
    
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! HabitTableViewCell
    
    cell.habitNameLabel.text = habit.name
    cell.habitmonImage.image = UIImage(named: habit.image!)
    cell.levelNumberLabel.text = "\(habit.level)"
    
    return cell
  }
  
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if (editingStyle == UITableViewCellEditingStyle.Delete) {
      // handle delete (by removing the data from your array and updating the tableview)
      let habit = habits[indexPath.row]
      
      let deletionAlert = UIAlertController(title: "Delete Habit", message: "Are you sure you want to remove this habit? This action cannot be undone.", preferredStyle: UIAlertControllerStyle.Alert)
      
      deletionAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
        try! self.realm.write {
          // almost like a fake initialization... because these values need to go back to how they were before, but because of the way our whole data model is structured, we can't just reinitialize it. oops haha. could have done that better.
          habit.active = false
          habit.level = 0
          habit.evolveLevel = 5
          habit.checked = false
          habit.cheatDays = 3
          habit.habitmon = "Egg"
          habit.image = "Egg"
          habit.profile = "A mysterious egg. I wonder what's inside?"
          habit.updatedAt = NSDate()
        }
        
        self.tableView.reloadData()
      }))
      
      deletionAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
        self.tableView.reloadData()
      }))
      
      presentViewController(deletionAlert, animated: true, completion: nil)
    }
  }
  
  // MARK: - Navigation
  
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
           //Get the new view controller using segue.destinationViewController.
           //Pass the selected object to the new view controller.
    
      if segue.identifier == "Show" {
        let habitDetailViewController = segue.destinationViewController as! HabitViewController
        
        // Get the cell that generated this segue.
        if let selectedHabitCell = sender as? HabitTableViewCell {
          let indexPath = tableView.indexPathForCell(selectedHabitCell)!
          let selectedHabit = habits[indexPath.row]
          habitDetailViewController.habit = selectedHabit
          
          segue.destinationViewController.title = selectedHabit.name
        }
      }
    }
  
  @IBAction func unwindToHabits(segue: UIStoryboardSegue) {
    
  }
  
}


