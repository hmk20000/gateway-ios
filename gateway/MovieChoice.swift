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
        tableView.separatorStyle = .none
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
        let title = cell.viewWithTag(102) as? UILabel
        let subtitle = cell.viewWithTag(103) as? UILabel
        
        var imageName:String?
        switch paramKey {
        case 0:
            imageName = "SF\((indexPath as NSIndexPath).row+1)btn.png"
        case 1:
            imageName = "JF\((indexPath as NSIndexPath).row+1)btn.png"
        case 2:
            imageName = "MD\((indexPath as NSIndexPath).row+1)btn.png"
        case 3:
            imageName = "GS\((indexPath as NSIndexPath).row+1)btn.png"
        default:
            imageName = ""
        }
        
        bgimage!.image = UIImage(named: imageName!)
        title?.text = row.title
        subtitle?.text = row.subtitle
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.black
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    var paramVO = MovieVO()
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nvc = segue.destination as? MoviePlay{
            nvc.paramVO = paramVO
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        paramVO = self.list[(indexPath as NSIndexPath).row]
        self.performSegue(withIdentifier: "seguePlay", sender: self)
    }
}
