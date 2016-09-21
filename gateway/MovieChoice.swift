//
//  MovieChoice.swift
//  gateway
//
//  Created by ming on 2016. 9. 20..
//  Copyright © 2016년 cccvlm. All rights reserved.
//

import UIKit


class MovieChoice: UITableViewController {
    var paramKey:Int = 0
    var paramTitle:String = ""
    var list = Array<MovieVO>()
    override func viewDidLoad() {
        let tmp = MovieDAO(Entity: "Movie")
        list = tmp.getAll(category: paramKey)
         
        self.title = paramTitle
        
        self.tableView.rowHeight = 160;
        tableView.separatorStyle = .None
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
        let title = cell.viewWithTag(102) as? UILabel
        let subtitle = cell.viewWithTag(103) as? UILabel
        
        var imageName:String?
        switch paramKey {
        case 0:
            imageName = "SF\(indexPath.row+1)btn.png"
        case 1:
            imageName = "JF\(indexPath.row+1)btn.png"
        case 2:
            imageName = "MD\(indexPath.row+1)btn.png"
        case 3:
            imageName = "GS\(indexPath.row+1)btn.png"
        default:
            imageName = ""
        }
        
        bgimage!.image = UIImage(named: imageName!)
        title?.text = row.title
        subtitle?.text = row.subtitle
        
        return cell
    }
    var paramVO = MovieVO()
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let nvc = segue.destinationViewController as? MoviePlay{
            nvc.paramVO = paramVO
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        paramVO = self.list[indexPath.row]
        self.performSegueWithIdentifier("seguePlay", sender: self)
    }
}