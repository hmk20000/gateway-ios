//
//  Tab2page1Controller1.swift
//  MissionHub
//
//  Created by ming on 2016. 8. 24..
//  Copyright © 2016년 cccvlm. All rights reserved.
//

import UIKit
import CoreData

class HomeCategory: UITableViewController {
    //var people = [FreshmanVO]()

    var list = Array<String>()
    override func viewDidLoad() {
        list.append("SHORT FILMS")
        list.append("JESUS")
        list.append("MAGDALENA")
        list.append("GOSPEL")
        list.append("HOW TO USE")
          
        self.tableView.rowHeight = 160;
        tableView.separatorStyle = .none
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden =  false
        
        //Status bar style and visibility
        UIApplication.shared.isStatusBarHidden = false
        UIApplication.shared.statusBarStyle = .lightContent
        
        //Change status bar color
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = UIColor.darkGray
        }
        
    }
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        
        let row = self.list[(indexPath as NSIndexPath).row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell")!
        let bgimage = cell.viewWithTag(101) as? UIImageView
        let label = cell.viewWithTag(102) as? UILabel
        
        bgimage!.image = UIImage(named: "home\((indexPath as NSIndexPath).row+1)btn.png")
        label?.text = row
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.black
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    var paramKey = 0
    var paramtitle = ""
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let nvc = segue.destination as? MovieChoice{
            nvc.paramKey = paramKey
            nvc.paramTitle = paramtitle
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        paramKey = (indexPath as NSIndexPath).row
        paramtitle = self.list[(indexPath as NSIndexPath).row]
        self.performSegue(withIdentifier: "segueNext", sender: self)
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
