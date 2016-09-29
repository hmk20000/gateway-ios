//
//  MovieNext2.swift
//  gateway
//
//  Created by ming on 2016. 9. 21..
//  Copyright © 2016년 cccvlm. All rights reserved.
//

import UIKit

class LinkPage{
    var isLink:Int?
    var question:String?
    var lvo:LinkVO?
}
class MovieNext: UITableViewController {
    
    var tmpList = Array<MovieVO>()
    var paramKey:Int = 0
    var paramTitle:String = ""
    
    var paramVO:MovieVO?
    var list = Array<LinkPage>()
    
    
    override func viewDidLoad() {
        
        /*let tmp = MovieDAO(Entity: "Movie")
        tmpList = tmp.getAll(category: paramKey)
        paramVO = tmpList[0]*/
        
        self.title = "Next"
        
        list = Array<LinkPage>()
        let qvoList = QuestionDAO().getAll(category: paramVO!.category!, index_key: paramVO!.index_key!)
        for tmpQ in qvoList{
            var lp = LinkPage()
            lp.isLink = 0
            lp.question = tmpQ.question
            list.append(lp)
            //print(lp.question)
            
            let lvoList = LinkDAO().getAll(category: tmpQ.category!, index_key: tmpQ.index_key!, question_key: tmpQ.question_key!)
            //print(lvoList.count)
            
            for tmpL in lvoList{
                
                lp = LinkPage()
                lp.isLink = 1
                lp.lvo = tmpL
                
                list.append(lp)
                
                lp = LinkPage()
                lp.isLink = 2
                
                list.append(lp)
            }
            
        }
        
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 68.0
        //self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        
        let row = self.list[(indexPath as NSIndexPath).row]
        var cell = UITableViewCell()
        if row.isLink == 0{
            cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell")!
            let label = cell.viewWithTag(101) as? UILabel
            
            label!.text = row.question
            self.tableView.rowHeight = UITableViewAutomaticDimension
        }else if row.isLink == 1{
            cell = tableView.dequeueReusableCell(withIdentifier: "LinkCell")!
            let label = cell.viewWithTag(101) as? UILabel
            let tmpL = row.lvo!
            //label?.text = findMovieName(category: tmpL.next_category!, index_key: tmpL.next_index_key!)
            label?.text = MovieDAO().getMovie(category: tmpL.next_category!, index_key: tmpL.next_index_key!).title
            self.tableView.rowHeight = UITableViewAutomaticDimension
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "BlankCell")!
            self.tableView.rowHeight = 5
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    var nextVO = MovieVO()
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nvc = segue.destination as? MoviePlay{
            nvc.paramVO = nextVO
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lp = self.list[(indexPath as NSIndexPath).row]
        if lp.isLink == 1{
            let tmpL = lp.lvo!
            nextVO = MovieDAO().getMovie(category: tmpL.next_category!, index_key: tmpL.next_index_key!)
            self.performSegue(withIdentifier: "segueNextMovie", sender: self)
        }        
    }
}
