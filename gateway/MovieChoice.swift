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
        let tmp = MovieDAO()
        list = tmp.getAll(category: paramKey)
         
        self.title = paramTitle
        
        self.tableView.rowHeight = 160;
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
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
        let index_key = (indexPath as NSIndexPath).row+1
        switch paramKey {
        case 0:
            imageName = "SF\(index_key)btn.png"
        case 1:
            imageName = "JF\(index_key)btn.png"
        case 2:
            imageName = "MD\(index_key)btn.png"
        case 3:
            imageName = "GS\(index_key)btn.png"
        case 4:
            imageName = "HU\(index_key)btn.png"
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
        
        if (paramVO.category == 4) && (paramVO.index_key == 3){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // in half a second..
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TutorialViewController")
                self.modalTransitionStyle = UIModalTransitionStyle.coverVertical
                self.modalPresentationStyle = .currentContext
                self.present(vc!, animated: true, completion: nil)
            }//TutorialViewController
        }else{
            self.performSegue(withIdentifier: "seguePlay", sender: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let title = cell.viewWithTag(102) as? UILabel
        let subtitle = cell.viewWithTag(103) as? UILabel
        UIView.animate(withDuration: 0.0, animations: {
            title?.frame.origin.y = (title?.frame.origin.y)! + 30
            subtitle?.frame.origin.y = (subtitle?.frame.origin.y)! + 30
            title?.alpha = 0.0
            subtitle?.alpha = 0.0
        })
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let title = cell.viewWithTag(102) as? UILabel
        let subtitle = cell.viewWithTag(103) as? UILabel
        UIView.animate(withDuration: 0.5, animations: {
            title?.frame.origin.y = (title?.frame.origin.y)! - 30
            subtitle?.frame.origin.y = (subtitle?.frame.origin.y)! - 30
            title?.alpha = 1
            subtitle?.alpha = 1
        })
    }
}
