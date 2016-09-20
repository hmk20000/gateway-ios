//
//  Tab2page1Controller1.swift
//  MissionHub
//
//  Created by ming on 2016. 8. 24..
//  Copyright © 2016년 cccvlm. All rights reserved.
//

import UIKit


class HomeCategory: UITableViewController {
    //var people = [FreshmanVO]()
    var list = Array<String>()
    override func viewDidLoad() {
        list.append("SHORT FILMS")
        list.append("JESUS FILMS")
        list.append("MAGDALENA")
        list.append("GOSPEL")
        list.append("HOW TO USE")
        
        self.tableView.rowHeight = 175;
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden =  false
        
        //Status bar style and visibility
        UIApplication.sharedApplication().statusBarHidden = false
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        //Change status bar color
        let statusBar: UIView = UIApplication.sharedApplication().valueForKey("statusBar") as! UIView
        if statusBar.respondsToSelector("setBackgroundColor:") {
            statusBar.backgroundColor = UIColor.darkGrayColor()
        }
        
    }
    override func tableView(tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(tableView: UITableView,
                            cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
        
        let row = self.list[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ListCell")!
        let bgimage = cell.viewWithTag(101) as? UIImageView
        let label = cell.viewWithTag(102) as? UILabel
        
        bgimage!.image = UIImage(named: "home\(indexPath.row+1)btn.png")
        label?.text = row
        
        
        return cell
    }
    var paramKey = 0
    var paramtitle = ""
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let nvc = segue.destinationViewController as? MovieChoice{
            nvc.paramKey = paramKey
            nvc.paramTitle = paramtitle
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        paramKey = indexPath.row
        paramtitle = self.list[indexPath.row]
        self.performSegueWithIdentifier("segueNext", sender: self)
    }
    /*if let nvc = self.storyboard?.instantiateViewControllerWithIdentifier("tabVC"){
     nvc.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
     self.presentViewController(nvc, animated: true, completion: nil)
     }*/
    
    // Override to support editing the table view.
    /*override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            people.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }*/
    /*override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //paramKey = self.people[indexPath.row].key!
        self.performSegueWithIdentifier("segueNext", sender: self)
    }*/
}