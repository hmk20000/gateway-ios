//
//  MovieNext2.swift
//  gateway
//
//  Created by ming on 2016. 9. 21..
//  Copyright © 2016년 cccvlm. All rights reserved.
//

import UIKit

class LinkPage{
    var isLink:Bool?
    var question:String?
    var lvo:LinkVO?
}
class MovieNext2: UITableViewController {
    
    var tmpList = Array<MovieVO>()
    var paramKey:Int = 0
    var paramTitle:String = ""
    
    var paramVO:MovieVO?
    var list = Array<LinkPage>()
    
    
    override func viewDidLoad() {
        /*let tmp = MovieDAO(Entity: "Movie")
        tmpList = tmp.getAll(category: paramKey)
        paramVO = tmpList[0]*/
        list = Array<LinkPage>()
        let qvoList = QuestionDAO(Entity: "Question").getAll(category: paramVO!.category!, index_key: paramVO!.index_key!)
        for tmpQ in qvoList{
            var lp = LinkPage()
            lp.isLink = false
            lp.question = tmpQ.question
            list.append(lp)
            //print(lp.question)
            
            let lvoList = LinkDAO(Entity: "Link").getAll(category: tmpQ.category!, index_key: tmpQ.index_key!, question_key: tmpQ.question_key!)
            //print(lvoList.count)
            
            for tmpL in lvoList{
                
                lp = LinkPage()
                lp.isLink = true
                lp.lvo = tmpL
                
                list.append(lp)
            }
        }
        
        tableView.separatorStyle = .None
        tableView.estimatedRowHeight = 68.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    override func tableView(tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(tableView: UITableView,
                            cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
        
        let row = self.list[indexPath.row]
        var cell = UITableViewCell()
        if row.isLink == false{
            cell = tableView.dequeueReusableCellWithIdentifier("QuestionCell")!
            let label = cell.viewWithTag(101) as? UILabel
            
            label!.text = row.question
        }else{
            cell = tableView.dequeueReusableCellWithIdentifier("LinkCell")!
            let label = cell.viewWithTag(101) as? UILabel
            let tmpL = row.lvo!
            //label?.text = findMovieName(category: tmpL.next_category!, index_key: tmpL.next_index_key!)
            label?.text = MovieDAO(Entity: "Movie").getMovie(category: tmpL.next_category!, index_key: tmpL.next_index_key!).title
        }
        return cell
    }
    var nextVO = MovieVO()
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let nvc = segue.destinationViewController as? MoviePlay{
            nvc.paramVO = nextVO
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let lp = self.list[indexPath.row]
        if lp.isLink == true{
            let tmpL = lp.lvo!
            nextVO = MovieDAO(Entity: "Movie").getMovie(category: tmpL.next_category!, index_key: tmpL.next_index_key!)
            self.performSegueWithIdentifier("segueNextMovie", sender: self)
        }        
    }
}