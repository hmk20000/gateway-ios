//
//  MovieQuestion2.swift
//  gateway
//
//  Created by ming on 2016. 9. 22..
//  Copyright © 2016년 cccvlm. All rights reserved.
//


import UIKit

class MovieQuestion: UITableViewController {
    
    var paramVO:MovieVO?
    
    override func viewDidLoad() {
        /*let tmp = MovieDAO(Entity: "Movie")
         paramVO = tmp.getAll(category: 0)[0]*/
        
        //self.title = "Question"
        
        tableView.estimatedRowHeight = 68.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.separatorStyle = .none
    }
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        switch indexPath.row {
        case 0, 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell")!
            let label = cell.viewWithTag(101) as? UILabel
            if indexPath.row == 0   { label?.text = "도입"   }
            else                    { label?.text = "심화"   }
        case 1, 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell")!
            let label = cell.viewWithTag(101) as? UILabel
            if indexPath.row == 1   { label?.text = paramVO?.question1   }
            else                    { label?.text = paramVO?.question2   }
        default: break
        }

        return cell
    }
}
