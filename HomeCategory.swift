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
    override func viewDidLoad() {
        //NSLog("test")
        /*self.tableView.rowHeight = 80;
        let apiURI = NSURL(string: "http://cccvlm.com/API/MissionHub/testList.php")
        
        let apidata : NSData? = NSData(contentsOfURL: apiURI!)
        
        do{
            let apiDictionary = try NSJSONSerialization.JSONObjectWithData(apidata!, options: []) as! NSDictionary
            var fvo:FreshmanVO
            for (k,tmp) in apiDictionary{
                fvo = FreshmanVO()
                fvo.key = Int(k as! String)
                fvo.name = tmp["name"] as? String
                fvo.phone = tmp["phonenumber"] as? String
                people.append(fvo)
            }
            self.tableView.reloadData()
        }catch{
            
        }*/
    }
    
    /*override func tableView(tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return self.people.count
    }*/
    
    /*override func tableView(tableView: UITableView,
                            cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
        
        let row = self.people[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ListCell")!
        let name = cell.viewWithTag(101) as? UILabel
        let phone = cell.viewWithTag(102) as? UILabel
        name?.text = row.name
        phone?.text = row.phone
        //cell.textLabel?.text = person.name
        //person.valueForKey("name") as? String
        
        return cell
    }*/
    var paramKey = 0
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let nvc = segue.destinationViewController as? Tab2Page2Controller{
            nvc.paramKey = paramKey
            /*nvc.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
             self.presentViewController(nvc, animated: true, completion: nil)*/
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        paramKey = self.people[indexPath.row].key!
        self.performSegueWithIdentifier("segueNext", sender: self)
    }
    /*if let nvc = self.storyboard?.instantiateViewControllerWithIdentifier("tabVC"){
     nvc.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
     self.presentViewController(nvc, animated: true, completion: nil)
     }*/
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            people.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }*/
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //paramKey = self.people[indexPath.row].key!
        self.performSegueWithIdentifier("segueNext", sender: self)
    }
}